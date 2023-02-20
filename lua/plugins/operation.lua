return {
  -- https://github.com/phaazon/hop.nvim
  -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible.
  -- It does so by annotating text in your buffer with hints,
  -- short string sequences for which each character represents a key to type to jump to the annotated text.
  -- Most of the time, those sequences’ lengths will be between 1 to 3 characters,
  -- making every jump target in your document reachable in a few keystrokes.
  {
    "phaazon/hop.nvim",
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })

      require('hop').setup()

    end,
  },

  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  -- A Neovim plugin for setting the commentstring option based on the cursor location in the file.
  -- The location is checked via treesitter queries.
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require'nvim-treesitter.configs'.setup { context_commentstring = { enable = true, enable_autocmd = false } }
    end,

  },

  -- https://github.com/numToStr/Comment.nvim
  -- Smart and Powerful commenting plugin for neovim
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ignore = '^$',
        toggler = {
          -- Line-comment toggle keymap
          line = '<leader>cc',
          -- Block-comment toggle keymap
          block = '<leader>cb',
        },

        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          -- Line-comment keymap
          line = '<leader>cc',
          -- Block-comment keymap
          block = '<leader>cb',
        },
      })
    end,
  },

  -- https://github.com/kylechui/nvim-surround
  -- Add/delete/change surrounding pairs
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<Nop>",
          insert_line = "<NOP>",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "<NOP>",
          visual_line = "<NOP>",
          delete = "ds",
          change = "cs",
        },
      })
    end,
  },

  -- https://github.com/junegunn/vim-easy-align
  -- A simple, easy-to-use Vim alignment plugin.
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("n", "<leader>a", "<Plug>(EasyAlign)")
      vim.keymap.set("v", "<leader>a", "<Plug>(EasyAlign)")
    end,

  },

  -- https://github.com/Hanaasagi/remote-copy.vim
  -- Copy the text in remote Vim to local clipboard. It depends on OSC52 escape sequences.
  -- Unlike other OSC52 Vim scripts (e.g. code snippet in chromium hterm),
  -- it solves the flash problem when copy the text.
  {
    "Hanaasagi/remote-copy.vim",
    config = function()
      vim.keymap.set("v", "<C-c>", [[y:call remote_copy#copy2clipboard(getreg('"'))<CR>]],
                     { silent = true, noremap = true, desc = "copy text" })
    end,
  },

  -- https://github.com/Hanaasagi/inflection.vim
  -- Binding the Python inflection in Vim.
  {
    "Hanaasagi/inflection.vim",
    config = function()
      vim.api.nvim_create_user_command("Inflection", "call inflection#inflect_current_word()", {})

      vim.api.nvim_create_user_command("InflectionVisual", "call inflection#inflect_visaul_block()", { range = 0 })
      vim.keymap.set("i", "<C-l>", [[<ESC>:call inflection#inflect_current_word_in_insert_mode()<CR>]],
                     { silent = false, noremap = true, desc = "inflect a word" })
    end,
  },

  -- https://github.com/ggandor/leap.nvim
  -- Leap is a general-purpose motion plugin for Neovim,
  -- with the ultimate goal of establishing a new standard interface for moving around
  -- in the visible area in Vim-like modal editors.
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require('leap')
      leap.set_default_keymaps()
    end,

  },

  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
          delay = 100,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = { relative_time = false },
      })

      -- https://github.com/lewis6991/gitsigns.nvim/issues/430
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#FFFFFF" })
    end,
  },

  -- https://github.com/nyngwang/NeoZoom.lua
  -- NeoZoom.lua aims to help you focus and maybe protect your left-rotated neck.
  {

    'nyngwang/NeoZoom.lua',
    config = function()
      require('neo-zoom').setup {
        -- top_ratio = 0,
        -- left_ratio = 0.225,
        -- width_ratio = 0.775,
        -- height_ratio = 0.925,
        -- border = 'double',
        -- disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
        -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
        exclude_buftypes = { 'terminal' },
        presets = {
          {
            filetypes = { 'dapui_.*', 'dap-repl' },
            config = { top_ratio = 0.25, left_ratio = 0.6, width_ratio = 0.4, height_ratio = 0.65 },
            callbacks = {
              function()
                vim.wo.wrap = true
              end,
            },
          },
        },
        -- popup = {
        --   -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
        --   -- This way you won't see two windows of the same buffer
        --   -- got updated at the same time.
        --   enabled = true,
        --   exclude_filetypes = {},
        --   exclude_buftypes = {},
        -- },
      }
      vim.keymap.set('n', '<leader>z', function()
        vim.cmd('NeoZoomToggle')
      end, { silent = true, nowait = true })
    end,

  },
}
