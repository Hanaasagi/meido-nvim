-- :help vim.keymap
local keymap = vim.keymap
local map = keymap.set

vim.g.mapleader = ","

-- use regex search
map("n", "/", "/\\v", { buffer = true })
map("v", "/", "/\\v", { buffer = true })

-- swap window position
map("n", "<Left>", "<C-w>H", { desc = "move current window to the left" })
map("n", "<Right>", "<C-w>L", { desc = "move current window to the right" })
map("n", "<Up>", "<C-w>K", { desc = "move current window to top" })
map("n", "<Down>", "<C-w>J", { desc = "move current window to bottom" })

-- disable Page Up/Down
map("n", "<PageUp>", "<Nop>", {})
map("n", "<PageDown>", "<Nop>", {})

-- disable backspace/delete
map("i", "<BS>", "<Nop>", {})
map("i", "<Char-0x010>", "<Nop>", {})
map("i", "<Del>", "<Nop>", {})
map("i", "<Char-0x07F>", "<Nop>", {})

-- cancel highlight
map("n", "<leader>/", ":nohls<CR>", { silent = true, noremap = true, desc = "cancel search highlight" })

-- convenient way to move between windows
map("n", "<C-j>", "<C-W>j", { silent = true, desc = "move to lower window" })
map("n", "<C-k>", "<C-W>k", { silent = true, desc = "move to upper side window" })
map("n", "<C-h>", "<C-W>h", { silent = true, desc = "move to left window" })
map("n", "<C-l>", "<C-W>l", { silent = true, desc = "move to right window" })

map("n", "<leader>w", ":w<CR>", { silent = false, noremap = true, desc = "write to file" })
map("n", "<leader>wq", ":wq<CR>", { silent = true, noremap = true, desc = "write to file and quit" })
map("n", "<leader>q", ":q<CR>", { silent = true, noremap = true, desc = "quit current window" })
map("n", "<leader>e", ":ccl<CR>", { silent = true, noremap = true, desc = "quit current window" })

map("c", "<C-j>", "<Down>", { noremap = true }) -- <t_kd>
map("c", "<C-k>", "<Up>", { noremap = true }) -- <t_ku>
map("c", "<C-a>", "<Home>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })

map("n", "-", ":m .+1<CR>==", { noremap = true })
map("n", "_", ":m .-2<CR>==", { noremap = true })

-- tab
map("n", "<leader>tn", ":tabnew<CR>", { silent = true, noremap = true, desc = "open new tab" })
map("n", "<leader>tm", "<C-W>T<CR>", { silent = true, noremap = true, desc = "move windwo to new tab" })
-- tab switch
map("n", "<leader>tf", ":tabfirst<CR>", { silent = true, desc = "switch to first tab" })
map("n", "<leader>tl", ":tablast<CR>", { silent = true, desc = "switch to last tab" })
map("n", "<leader>tj", ":tabnext<CR>", { silent = true, desc = "switch to next tab" })
map("n", "<leader>tk", ":tabprev<CR>", { silent = true, desc = "switch to prev tab" })

-- jump to specific tab
local i = 0
for i = 1, 9 do
  map("n", string.format("<leader>%d", i), string.format("%dgt", i), { silent = true, noremap = true })
end

-- Helper function: Close the current tab, split windows, and reopen buffers
local function tab_to_windows(split_type)
  local bufnums = vim.fn.tabpagebuflist()
  vim.cmd("tabclose") -- Close the current tab
  vim.cmd("topleft " .. split_type) -- Open the first window (split/vsplit)

  for _, buf in ipairs(bufnums) do
    vim.cmd("sbuffer " .. buf) -- Open buffer in the split
    vim.cmd("wincmd _") -- Maximize the current window
  end

  vim.cmd("wincmd t") -- Focus the first window
  vim.cmd("quit") -- Quit the initial split
  vim.cmd("wincmd =") -- Equalize window sizes
end

-- Vertical split: Command and mapping
vim.api.nvim_create_user_command("TabVSplit2Window", function()
  tab_to_windows("vsplit")
end, {})

vim.keymap.set("n", "<leader>tv", ":TabVSplit2Window<CR>", { silent = true, noremap = true })

-- Horizontal split: Command and mapping
vim.api.nvim_create_user_command("TabSplit2Window", function()
  tab_to_windows("split")
end, {})

vim.keymap.set("n", "<leader>ts", ":TabSplit2Window<CR>", { silent = true, noremap = true })

map("n", "<Space>", "i<Space><Esc>", { silent = true, noremap = true })
