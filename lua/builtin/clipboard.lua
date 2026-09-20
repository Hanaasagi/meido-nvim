-- Copy text out of a remote (SSH) Neovim into the local system clipboard using
-- OSC52 escape sequences.
--
-- This is a pure-Lua reimplementation of https://github.com/Hanaasagi/remote-copy.vim
-- It drops the python3 dependency (and the /proc + pid guessing that came with
-- it): Lua runs inside the `nvim --embed` core process, and `nvim_ui_send()`
-- hands the bytes straight to the TUI process that owns the terminal.
--
-- The emitted sequences are byte-for-byte identical to the original plugin
-- (verified for charwise / linewise / blockwise / multibyte / 64KB payloads, in
-- both the plain and the tmux-passthrough branch).
--
-- OSC52 is only needed when Neovim runs on a remote host over SSH. Locally
-- (e.g. macOS), Neovim talks to the system clipboard directly via its builtin
-- provider (pbcopy/pbpaste).

local M = {}

M.opts = {
  -- Pad blockwise (<C-v>) selections into a rectangle before sending.
  -- Off by default so the output matches remote-copy.vim exactly.
  pad_blockwise = false,
}

function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})
end

local function is_under_tmux()
  local tmux = vim.env.TMUX
  return tmux ~= nil and vim.trim(tmux) ~= ""
end

--- Wrap text into an OSC52 "set clipboard" sequence, terminated by BEL like the
--- original plugin does. Under tmux the sequence is additionally wrapped in a
--- DCS passthrough, which needs `set -g allow-passthrough on` (tmux >= 3.3).
local function encode(text)
  local body = "\027]52;c;" .. vim.base64.encode(text) .. "\007"
  if is_under_tmux() then
    return "\027Ptmux;\027" .. body .. "\027\\"
  end
  return body
end

local function send(sequence)
  -- Neovim >= 0.12: the documented way to reach the host terminal.
  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(sequence)
    return
  end

  -- Fallback for 0.10/0.11: write to the stdout of the TUI process, which is
  -- the parent of the core process this Lua runs in. Unlike the python host,
  -- that parent is stable, so no version sniffing is required.
  local file = io.open("/proc/" .. tostring(vim.uv.os_getppid()) .. "/fd/1", "a")
  if file then
    file:write(sequence)
    file:flush()
    file:close()
  end
end

--- Send arbitrary text to the system clipboard.
function M.copy(text)
  send(encode(text))
  -- Mirrors the `redraw!` of the original plugin. Strictly speaking unnecessary
  -- now that nvim_ui_send() cannot corrupt the screen, kept for identical feel.
  vim.cmd("redraw!")
end

--- Text of the unnamed register, as filled by the yank the mapping just ran.
local function unnamed_register_text()
  if not M.opts.pad_blockwise then
    return vim.fn.getreg('"')
  end

  -- Blockwise registers report their width as ^V<cols>; pad short rows so the
  -- copied block stays rectangular once pasted elsewhere.
  local width = tonumber(vim.fn.getregtype('"'):match("^\022(%d+)$"))
  if not width then
    return vim.fn.getreg('"')
  end

  local lines = {}
  for _, line in ipairs(vim.fn.getreg('"', 1, true)) do
    local padding = width - vim.fn.strdisplaywidth(line)
    lines[#lines + 1] = padding > 0 and (line .. string.rep(" ", padding)) or line
  end
  return table.concat(lines, "\n")
end

--- Called by the <C-c> mapping right after a real yank, so `"`/`0` keep their
--- usual meaning: <C-c> behaves like a normal copy that also reaches the OS.
function M.copy_unnamed()
  M.copy(unnamed_register_text())
end

local is_remote = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

if is_remote then
  -- The leading `y` is a genuine yank; only the transport differs from a plain
  -- `y`. `<Cmd>` avoids entering command-line mode the way `:call` used to.
  vim.keymap.set(
    "v",
    "<C-c>",
    [[y<Cmd>lua require("builtin/clipboard").copy_unnamed()<CR>]],
    { silent = true, noremap = true, desc = "copy text" }
  )
else
  -- Visual mode copies the selection, normal mode copies the current line.
  vim.keymap.set("v", "<C-c>", '"+y', { silent = true, noremap = true, desc = "copy selection to system clipboard" })
  vim.keymap.set("n", "<C-c>", '"+yy', { silent = true, noremap = true, desc = "copy line to system clipboard" })
end

return M
