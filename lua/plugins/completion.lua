return {
  -- https://github.com/windwp/nvim-autopairs
  -- A super powerful autopair plugin for Neovim that supports multiple characters.
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- https://github.com/folke/neodev.nvim
  -- Neovim setup for init.ua and plugin development with full signature help,
  -- docs and completion for the nvim lua API.
  { 'folke/neodev.nvim', lazy = true },

  -- https://github.com/jubnzv/virtual-types.nvim
  -- This plugin shows type annotations for functions in virtual text using built-in LSP client.
  -- { "jubnzv/virtual-types.nvim" },

  -- https://github.com/simrat39/rust-tools.nvim
  -- A plugin to improve your rust experience in neovim.
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")

      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  },

  -- https://github.com/rafamadriz/friendly-snippets
  -- Snippets collection for a set of different programming languages for faster development.
  { "rafamadriz/friendly-snippets" },

  -- https://github.com/L3MON4D3/LuaSnip
  {
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip').filetype_extend("typescript", { "javascript" })
    end,
  },

  -- https://github.com/saadparwaiz1/cmp_luasnip
  -- luasnip completion source for nvim-cmp
  { "saadparwaiz1/cmp_luasnip" },

  -- nvim cmp related
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "dmitmel/cmp-cmdline-history" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },

  -- https://github.com/hrsh7th/cmp-nvim-lsp
  -- nvim-cmp source for neovim's built-in language server client.
  { "hrsh7th/cmp-nvim-lsp" },

  { "onsails/lspkind.nvim" },

  -- https://github.com/hrsh7th/nvim-cmp
  -- A completion engine plugin for neovim written in Lua.
  -- Completion sources are installed from external repositories and "sourced".
  {
    "hrsh7th/nvim-cmp",
    config = function()
      -- require("cmp").setup({ sources = { { name = 'nvim_lsp' } } })

      local cmp = require 'cmp'
      local types = require("cmp.types")
      local str = require("cmp.utils.str")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },

        formatting = {
          fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
          format = lspkind.cmp_format({
            -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode = 'symbol_text',
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            maxwidth = 50,
            -- when popup menu exceed maxwidth,
            -- the truncated part would show ellipsis_char instead (must define maxwidth first)
            ellipsis_char = '...',

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            -- before = function(entry, vim_item)
            --  return vim_item
            -- end,
            before = function(entry, vim_item)
              -- Get the full snippet (and only keep first line)
              local word = entry:get_insert_text()
              if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                word = vim.lsp.util.parse_snippet(word)
              end
              word = str.oneline(word)

              -- concatenates the string
              -- local max = 50
              -- if string.len(word) >= max then
              -- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
              -- 	word = before .. "..."
              -- end

              if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and
                string.sub(vim_item.abbr, -1, -1) == "~" then
                word = word .. "~"
              end
              vim_item.abbr = word

              return vim_item
            end,
          }),
        },
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },

        -- Reference
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/mapping.lua
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/cmp.lua
        mapping = {
          ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
          ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4),
          --                        { 'i', 'c' }),
          -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4),
          --                        { 'i', 'c' }),

          -- ['<C-c>'] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, { { name = 'nvim_lsp_signature_help' } }, {
          { name = "path", option = { label_trailing_slash = false, trailing_slash = false } },
          { name = 'buffer' },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, { { name = 'buffer' } }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- BUG: There is a bug https://github.com/hrsh7th/cmp-path/issues/40
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path', option = { label_trailing_slash = false, trailing_slash = false } },
        }, { { name = 'cmdline', keyword_length = 2 } }),
      })

      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- local cmp = require('cmp')
      -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require("neodev").setup({})
      require('lspconfig')['lua_ls'].setup {
        settings = { Lua = { completion = { callSnippet = "Replace" } } },
        capabilities = capabilities,
      }
      require('lspconfig')['pyright'].setup { capabilities = capabilities }
      -- use rust-tools.nvim to setup
      -- require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }
      require('lspconfig')['tsserver'].setup { capabilities = capabilities }
      require('lspconfig')['gopls'].setup { capabilities = capabilities }
    end,
  },

}
