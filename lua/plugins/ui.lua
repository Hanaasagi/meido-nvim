return {
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    config = function()
      -- vim.cmd.colorscheme("tokyonight-moon")
    end,

  },
  -- https://github.com/ellisonleao/gruvbox.nvim
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local config = require("gruvbox").config
      local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)

      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        dim_inactive = false,
        transparent_mode = false,
        overrides = {
          String = { italic = false },
          DiagnosticVirtualTextError = { fg = colors.red, underline = true, bold = true, italic = true },
          DiagnosticVirtualTextWarn = { fg = colors.yellow, underline = true, bold = true, italic = true },
          DiagnosticVirtualTextInfo = { fg = colors.blue, underline = true, bold = true, italic = true },
          DiagnosticVirtualTextHint = { fg = colors.aqua, underline = true, bold = true, italic = true },
        },
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- https://github.com/nvim-zh/colorful-winsep.nvim
  -- configurable window separtor
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require('colorful-winsep').setup()
    end,
  },

  -- https://github.com/levouh/tint.nvim
  -- Tint inactive windows in Neovim using window-local highlight namespaces.
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({ tint = -60 })
    end,

  },

  -- https://github.com/norcalli/nvim-colorizer.lua
  -- A high-performance color highlighter for Neovim which has no external
  -- dependencies! Written in performant Luajit.
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ 'css', 'javascript', 'typescript', 'html' })
    end,

  },

  -- https://github.com/nacro90/numb.nvim
  -- numb.nvim is a Neovim plugin that peeks lines of the buffer in non-obtrusive way.
  {
    "nacro90/numb.nvim",
    config = function()
      require('numb').setup()
    end,
  },

  -- https://github.com/RRethy/vim-illuminate
  -- Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
  -- Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    event = 'BufRead',
    config = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
        pattern = "*",
        callback = function()
          local color = "#2d323e"
          vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = color, bold = true })
          vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = color, bold = true })
          vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = color, bold = true })
        end,
      })
      return

    end,
  },

  -- https://github.com/DanilaMihailov/beacon.nvim
  -- Whenever cursor jumps some distance or moves between windows,
  -- it will flash so you can see where it is.
  -- This plugin is heavily inspired by emacs package beacon.
  { "danilamihailov/beacon.nvim", event = "BufRead" },

  -- https://github.com/gen740/SmoothCursor.nvim
  -- It is easy to lose current cursor position, when using commands like % or <c-f>,<c-b>.
  -- This plugin add sub-cursor to show scroll direction!!
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require('smoothcursor').setup({
        fancy = { head = { cursor = "▶", texthl = "SmoothCursor", linehl = nil }, enable = true },
        -- animate if threshold lines jump
        threshold = 10,
        -- disable on float window
        disable_float_win = true,
      })
    end,

  },

  -- https://github.com/akinsho/bufferline.nvim
  -- A snazzy buffer line (with tabpage integration) for Neovim built using lua.
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup()
    end,
  },

  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- This plugin adds indentation guides to all lines (including empty lines).
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      -- vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup {
        char = "¦",
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end,

  },

  -- https://github.com/nvim-lualine/lualine.nvim
  -- A blazing fast and easy to configure Neovim statusline written in Lua.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = '|',
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'encoding', 'fileformat', 'filetype', 'progress' },
          lualine_z = { { 'location', separator = { left = '', right = '' }, left_padding = 2 } },
        },
        -- only work in non global statusline
        inactive_sections = {},
        tabline = {},
        extensions = {},
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = 'BufRead',
    config = function()
      require("fidget").setup()
    end,

  },

  -- https://github.com/bronson/vim-trailing-whitespace
  -- This plugin causes trailing whitespace to be highlighted in red.
  -- To fix the whitespace errors, call :FixWhitespace.
  {
    "bronson/vim-trailing-whitespace",
    config = function()
      vim.keymap.set("n", "<leader><space>", ":FixWhitespace<CR>", { silent = true, desc = "strip whitespace" })
    end,
  },

  -- https://github.com/folke/todo-comments.nvim
  -- todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO,
  -- HACK, BUG in your code base.
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- https://github.com/karb94/neoscroll.nvim
  -- a smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end,
  },

  -- https://github.com/petertriho/nvim-scrollbar
  -- Extensible Neovim Scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- https://github.com/kevinhwang91/nvim-hlslens
  -- nvim-hlslens helps you better glance at matched information,
  -- seamlessly jump between matched instances.
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      -- https://github.com/petertriho/nvim-scrollbar#setup-packer

      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup({
        -- override_lens = function() end,
      })
      local map = vim.api.nvim_set_keymap

      local kopts = { noremap = true, silent = true }

      map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      map('n', '<leader>o', '<Cmd>noh<CR>', kopts)
    end,
  },

  -- TODO it's not work
  -- {
  --     "kien/rainbow_parentheses.vim",
  --     config = function()
  --         group = vim.api.nvim_create_augroup("rainbow_augroup",
  --                                             { clear = true })
  --         vim.api.nvim_create_autocmd("VimEnter", {
  --             group = group,
  --             pattern = "*",
  --             command = "RainbowParenthesesToggle",
  --         })
  --         vim.api.nvim_create_autocmd("Syntax", {
  --             group = group,
  --             pattern = "*",
  --             command = "RainbowParenthesesLoadRound",
  --         })
  --         vim.api.nvim_create_autocmd("Syntax", {
  --             group = group,
  --             pattern = "*",
  --             command = "RainbowParenthesesLoadSquare",
  --         })
  --         vim.api.nvim_create_autocmd("Syntax", {
  --             group = group,
  --             pattern = "*",
  --             command = "RainbowParenthesesLoadBraces",
  --         })
  --     end,
  -- },
}
