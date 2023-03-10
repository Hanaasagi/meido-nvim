-- When and how to draw the signcolumn. Valid values are:
-- vim.wo.signcolumn = "auto:2"
vim.wo.signcolumn = "yes:1"

-- All options see ':help option-list'
local opt = vim.opt

-- GUI: settings for cursor shape and blinking
opt.guicursor = 'n-v-c-i:block'
opt.termguicolors = true
-- print the line number in front of each line
opt.number = true
-- show relative line number in front of each line
opt.relativenumber = true

-- show cursor line and column in the status line
opt.ruler = true

-- TODO set t_ut =
-- TODO au InsertLeave * set nopaste
-- TODO set backspace=2

opt.encoding = 'utf-8'

-- tells when last window has status lines
opt.laststatus = 2

-- long lines wrap and continue on the next line
opt.wrap = false

-- don't unload buffer when it is |abandon|ed
opt.hidden = true

-- no ignore case when pattern has uppercase
opt.smartcase = true
-- smart autoindenting for C programs
opt.smartindent = true
-- use 'shiftwidth' when inserting <Tab>
opt.smarttab = true
-- number of spaces that <Tab> uses while editing
opt.softtabstop = 4

-- ignore case in search patterns
opt.ignorecase = true

-- keep backup file after overwriting a file
opt.backup = false
-- whether to use a swapfile for a buffer
opt.swapfile = false

-- minimum nr. of lines above and below cursor
opt.scrolloff = 3

-- use spaces when <Tab> is inserted
opt.expandtab = true
-- number of spaces that <Tab> in file uses
opt.tabstop = 4
-- number of spaces to use for (auto)indent step
opt.shiftwidth = 4
-- Disable mouse in any mode
opt.mouse = nil

-- set to display all folds open
opt.foldenable = true
opt.foldmethod = 'indent'
-- close folds with a level higher than this
opt.foldlevel = 99

-- use menu for command line completion
opt.wildmenu = true
-- mode for 'wildchar' command-line expansion
opt.wildmode = 'longest,list,full'
-- opt.background='dark'

-- new window from split is below the current one
opt.splitbelow = true
-- new window is put right of the current one
opt.splitright = true

-- highlight the screen column of the cursor
opt.cursorcolumn = true
-- highlight the screen line of the cursor
opt.cursorline = true
-- highlight matches with last search pattern
opt.hlsearch = true
-- highlight match while typing search pattern
opt.incsearch = true

-- local api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("FocusLost", { pattern = "*", command = ":set norelativenumber number" })

vim.api.nvim_create_autocmd("FocusGained", { pattern = "*", command = ":set relativenumber" })

vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = ":set norelativenumber number" })

vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = ":set relativenumber" })

-- auto goto last modify location
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],

})

-- nvim diagnostic settings
vim.diagnostic.config({
  virtual_text = { prefix = "⚠", spacing = 8 },
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
})

local function setupDimCursorLine()
  local old_guicursor, old_cursorline, old_cursorcolumn

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      old_guicursor = vim.opt.guicursor
      old_cursorline = vim.opt.cursorline
      old_cursorcolumn = vim.opt.cursorcolumn
    end,
  })

  vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
    callback = function()
      vim.opt.guicursor = "a:noCursor"
      vim.opt.cursorline = false
      vim.opt.cursorcolumn = false
    end,
  })

  vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
    callback = function()
      vim.opt.guicursor = old_guicursor
      vim.opt.cursorline = old_cursorline
      vim.opt.cursorcolumn = old_cursorcolumn
    end,
  })
end

setupDimCursorLine()
