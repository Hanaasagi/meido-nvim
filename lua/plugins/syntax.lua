return {
  -- https://github.com/windwp/nvim-ts-autotag
  -- Use treesitter to autoclose and autorename html tag. It work with html,tsx,vue,svelte,php,rescript.
  {
    "windwp/nvim-ts-autotag",
    -- config = function()
    --  require('nvim-ts-autotag').setup()
    -- end,
  },

  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  -- Lightweight alternative to context.vim implemented with nvim-treesitter.
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        -- max_lines=8
        multiline_threshold = 1,
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- Syntax aware text-objects, select, move, swap, and peek support.
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- https://github.com/RRethy/nvim-treesitter-textsubjects
  -- Location and syntax aware text objects which *do what you mean*
  -- { "RRethy/nvim-treesitter-textsubjects" },

  -- https://github.com/nvim-treesitter/nvim-treesitter
  --  Treesitter configurations and abstraction layer for Neovim.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Required by "windwp/nvim-ts-autotag"
        autotag = { enable = true },
        -- Required by "andymass/vim-matchup"
        matchup = {
          enable = false, -- mandatory, false will disable the whole extension
          -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
          -- [options]
        },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ai"] = "@call.outer",
              ["ii"] = "@call.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]o"] = "@loop.*",
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
            goto_next = { ["]d"] = "@conditional.outer" },
            goto_previous = { ["[d"] = "@conditional.outer" },
          },
          lsp_interop = {
            enable = true,
            border = "none",
            peek_definition_code = { ["<leader>sd"] = "@function.outer", ["<leader>sD"] = "@class.outer" },
          },
        },

        ensure_installed = {
          "lua",
          "rust",
          "go",
          "python",
          -- Frontend
          "typescript",
          "css",
          "javascript",
          "tsx",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        highlight = {
          enable = true,
          -- list of language that will be disabled
          disable = {},
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- https://github.com/nvim-treesitter/playground
  -- View treesitter information directly in Neovim!
  {
    "nvim-treesitter/playground",
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  -- https://github.com/editorconfig/editorconfig-vim
  -- This is an EditorConfig plugin for Vim. This plugin can be found on both GitHub and Vim online.
  { "editorconfig/editorconfig-vim", event = "BufRead" },
}
