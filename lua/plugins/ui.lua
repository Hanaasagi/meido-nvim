return {
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    priority = 1000,

    config = function()
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },

  -- https://github.com/catppuccin/nvim
  { "catppuccin/nvim", name = "catppuccin", priority = -1 },
  -- https://github.com/rebelot/kanagawa.nvim
  { "rebelot/kanagawa.nvim", name = "kanagawa", priority = -1 },

  -- https://github.com/nvim-zh/colorful-winsep.nvim
  -- configurable window separtor
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup()
    end,
  },

  -- https://github.com/levouh/tint.nvim
  -- Tint inactive windows in Neovim using window-local highlight namespaces.
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({
        -- Darken colors, use a positive value to brighten
        tint = -30,
        -- Saturation to preserve
        saturation = 0.38,
        -- Tint background portions of highlight groups
        tint_background_colors = false,
        highlight_ignore_patterns = { "DiagnosticVirtualText*" },
      })
    end,
  },

  -- https://github.com/norcalli/nvim-colorizer.lua
  -- A high-performance color highlighter for Neovim which has no external
  -- dependencies! Written in performant Luajit.
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "javascript", "typescript", "html", "lua" })
    end,
  },

  -- https://github.com/nacro90/numb.nvim
  -- numb.nvim is a Neovim plugin that peeks lines of the buffer in non-obtrusive way.
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  -- https://github.com/RRethy/vim-illuminate
  -- Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
  -- Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
        pattern = "*",
        callback = function()
          --[[ local color = "#2d323e"
          vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = color, bold = true })
          vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = color, bold = true })
          vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = color, bold = true }) ]]
        end,
      })
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
      require("smoothcursor").setup({
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
    main = "ibl",
    config = function()
      vim.opt.termguicolors = true
      vim.opt.list = false
      -- vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "eol:↴"

      local highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD" })
      end)

      hooks.register(hooks.type.ACTIVE, function(bufnr)
        return vim.opt_local.filetype:get() ~= "go"
      end)

      require("ibl").setup({
        indent = { char = "¦", highlight = highlight },
        whitespace = { highlight = highlight, remove_blankline_trail = false },
        scope = { enabled = true, show_start = true },
      })
    end,
  },

  -- https://github.com/nvim-lualine/lualine.nvim
  -- A blazing fast and easy to configure Neovim statusline written in Lua.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local idx = 1
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight-moon",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            function()
              if vim.api.nvim_get_mode().mode == "n" then
                local bufnr = vim.api.nvim_get_current_buf()
                return vim.b[bufnr].gitsigns_blame_line or ""
              end
              -- if vim.api.nvim_get_mode().mode == "i" then
              --   if not pcall(require, 'lsp_signature') then
              --     return ""
              --   end
              --   local sig = require("lsp_signature").status_line(20)
              --   return sig.label .. "🐼" .. sig.hint
              -- end
              return ""
            end,
          },
          lualine_x = {},
          lualine_y = { "encoding", { "fileformat", icons_enabled = false }, "filetype", "progress" },
          lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
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
    event = "BufRead",
    config = function()
      require("fidget").setup()
    end,
  },

  -- https://github.com/bronson/vim-trailing-whitespace
  -- This plugin causes trailing whitespace to be highlighted in red.
  -- To fix the whitespace errors, call :FixWhitespace.
  -- {
  --  "bronson/vim-trailing-whitespace",
  --  config = function()
  --    vim.keymap.set("n", "<leader><space>", ":FixWhitespace<CR>", { silent = true, desc = "strip whitespace" })
  --  end,
  -- },

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
      require("neoscroll").setup()
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

  {
    "folke/noice.nvim",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          progress = { enabled = false },
          signature = { enabled = false },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        views = { cmdline_popup = { position = { row = "40%", col = "50%" } } },
      })
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

      map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      map("n", "<leader>o", "<Cmd>noh<CR>", kopts)
    end,
  },

  {
    "HiPhish/nvim-ts-rainbow2",
    enabled = false,
    config = function()
      vim.cmd([[highlight TSRainbowRed guifg=#E06C75 gui=nocombine]])
      vim.cmd([[highlight TSRainbowYellow guifg=#E5C07B gui=nocombine]])
      vim.cmd([[highlight TSRainbowGreen  guifg=#98C379 gui=nocombine]])
      vim.cmd([[highlight TSRainbowBlue guifg=#56B6C2 gui=nocombine]])
      vim.cmd([[highlight TSRainbowCyan guifg=#61AFEF gui=nocombine]])
      vim.cmd([[highlight TSRainbowViolet guifg=#C678DD gui=nocombine]])
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          -- list of languages you want to disable the plugin for
          disable = { "jsx", "cpp" },
          -- Which query to use for finding delimiters
          query = "rainbow-parens",
          -- Highlight the entire buffer all at once
          strategy = require("ts-rainbow").strategy.global,
          hlgroups = {
            "TSRainbowRed",
            "TSRainbowYellow",
            "TSRainbowGreen",
            "TSRainbowBlue",
            "TSRainbowCyan",
            -- 'TSRainbowOrange',
            "TSRainbowViolet",
          },
        },
      })
    end,
  },

  -- {
  --   "echasnovski/mini.animate",
  --   enabled = false,
  --   config = function()
  --     require('mini.animate').setup()
  --   end,
  -- },
}
