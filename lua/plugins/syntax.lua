return {
  -- https://github.com/windwp/nvim-ts-autotag
  -- Use treesitter to autoclose and autorename html tag. It work with html,tsx,vue,svelte,php,rescript.
  {
    "windwp/nvim-ts-autotag",
    opts = {},
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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            },
          },
        },
      })
    end,
  },

  -- https://github.com/RRethy/nvim-treesitter-textsubjects
  -- Location and syntax aware text objects which *do what you mean*
  -- { "RRethy/nvim-treesitter-textsubjects" },

  -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      local ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "rust",
        "go",
        "python",
        -- Frontend
        "typescript",
        "css",
        "javascript",
        "tsx",
        "html",
      }

      ts.install(ensure_installed, { summary = true })

      local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = {
          "lua",
          "vim",
          "help",
          "query",
          "rust",
          "go",
          "python",
          "typescript",
          "tsx",
          "javascript",
          "css",
          "html",
        },
        callback = function()
          local ok, err = pcall(vim.treesitter.start)
          if ok then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          else
            vim.notify_once(("treesitter start failed: %s"):format(err), vim.log.levels.WARN)
          end
        end,
      })

      local attempted = {}
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        group = group,
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang or lang == "" or attempted[lang] then
            return
          end
          attempted[lang] = true
          if vim.tbl_contains(ts.get_installed(), lang) then
            return
          end
          if not vim.tbl_contains(ts.get_available(), lang) then
            return
          end
          ts.install(lang)
        end,
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
