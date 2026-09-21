-- Editor glue for the pure-Lua `inflection` package (Hanaasagi/inflection.lua).
--
-- This replaces Hanaasagi/inflection.vim, which reached the Python `inflection`
-- package through a python3 host. The commands, mappings, prompt, register and
-- cursor effects are deliberately identical, so nothing about using it changes;
-- only the transport does.
--
-- The string transformations themselves live in the package and are verified
-- against the reference implementation there, not here. This file is only the
-- editor-facing half.

local inflection = require("inflection")
local utf8 = require("inflection.utf8")

local M = {}

-- The prompt offers eight shortcuts. `uppercase`/`lowercase` are not part of the
-- inflection package (upstream binds them to Python's str.upper/str.lower), so
-- they come from the package's Unicode layer, which is verified equivalent.
local SHORTCUTS = {
  U = utf8.upper,
  L = utf8.lower,
  _ = inflection.underscore,
  c = function(word)
    return inflection.camelize(word, false)
  end,
  C = function(word)
    return inflection.camelize(word, true)
  end,
  ["-"] = inflection.dasherize,
  P = inflection.pluralize,
  S = inflection.singularize,
}

-- Same dict literal the original plugin built, evaluated *inside* VimL so that
-- join(keys(...)) uses Vim's own hash ordering. Going through a Lua table would
-- not work: LuaJIT randomises string hashing per process, so the prompt would be
-- reshuffled on every start.
local SHORTCUT_ORDER = vim.fn.eval(
  [[join(keys({'U':'uppercase','L':'lowercase','_':'underscore','c':'camelize',]]
    .. [['C':'Camelize','-':'dasherize','P':'pluralize','S':'singularize'}))]]
)

--- Ask which inflection to apply. Returns the transform, or nil if the key was
--- not one of the shortcuts.
local function ask_format_name()
  -- `echom` in the original: displayed, and kept in :messages history.
  vim.api.nvim_echo({ { "Select Inflection (" .. SHORTCUT_ORDER .. "):" } }, true, {})

  local key = vim.fn.nr2char(vim.fn.getchar())
  local transform = SHORTCUTS[key]
  if transform == nil then
    vim.api.nvim_echo({ { "Invalid option" } }, true, {})
    return nil
  end
  return transform
end

--- Inflect the word under the cursor.
---
--- The replacement goes in through a real `ciw`, exactly as before, so the
--- unnamed register and undo behaviour are unchanged.
---
---@param transform function|nil nil makes this a no-op, matching the original's
---   `_dispatch` returning None for an unknown format name
---@param focus_end boolean|nil restore the cursor to the end of the new word
function M.inflect_current_word(transform, focus_end)
  if transform == nil then
    return
  end

  -- getcursorcharpos() returns {bufnum, lnum, col, off, curswant}.
  local pos = vim.fn.getcursorcharpos()
  local lnum, col = pos[2], pos[3]

  local current_word = vim.fn.expand("<cword>")
  local new_word = transform(current_word)

  -- Python measured len() in code points, not bytes.
  local length_diff = utf8.len(new_word) - utf8.len(current_word)

  vim.cmd("normal! ciw" .. new_word)

  if focus_end then
    vim.fn.setcursorcharpos(lnum, col + length_diff + 1)
  end
end

--- Insert-mode entry point: inflect, then go back to insert mode and nudge the
--- cursor past the word when it ends on a word character.
function M.inflect_current_word_in_insert_mode()
  M.inflect_current_word(ask_format_name(), true)
  vim.cmd("startinsert")

  -- The original indexes the line with getline(".")[col(".") - 1], which in
  -- Neovim yields a single *byte*; String.sub at col is the same byte.
  local line, col = vim.fn.getline("."), vim.fn.col(".")
  if vim.fn.charclass(line:sub(col, col)) == 2 then
    vim.fn.cursor(vim.fn.line("."), col + 1)
  end
end

--- Inflect the word at the same column on every line of the last visual range.
function M.inflect_visaul_block()
  local start_pos, end_pos = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  local line_start, column_start = start_pos[2], start_pos[3]
  local line_end = end_pos[2]

  -- Asked once, before the loop, as in the original. An invalid key yields nil
  -- and every iteration below becomes a no-op - but the cursor still walks the
  -- lines, which is also what the original did.
  local transform = ask_format_name()

  local cur_line = line_start
  while cur_line <= line_end do
    vim.fn.cursor(cur_line, column_start)
    cur_line = cur_line + 1
    M.inflect_current_word(transform)
  end
end

vim.api.nvim_create_user_command("Inflection", function()
  M.inflect_current_word(ask_format_name())
end, {})

vim.api.nvim_create_user_command("InflectionVisual", M.inflect_visaul_block, { range = 0 })

-- `<ESC>` first, as in the original: the inflection runs `normal! ciw...`, which
-- must not execute while still in insert mode. `<Cmd>` rather than `:` keeps the
-- command line out of the way; `silent = false` is retained because the prompt
-- has to stay visible while getchar() waits.
vim.keymap.set(
  "i",
  "<C-l>",
  [[<ESC><Cmd>lua require("builtin/inflection").inflect_current_word_in_insert_mode()<CR>]],
  { silent = false, noremap = true, desc = "inflect a word" }
)

return M
