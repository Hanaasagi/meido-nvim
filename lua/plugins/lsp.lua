return {

  -- https://github.com/williamboman/mason.nvim
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,

  },
  -- https://github.com/williamboman/mason-lspconfig.nvim
  -- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Server List: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        ensure_installed = {
          -- Lua
          "lua_ls",
          -- Rust
          "rust_analyzer",
          -- Golang
          "gopls",
          -- Python
          "pyright",
          -- Typescript
          "tsserver",
          -- ESLint
          "eslint",
          -- Tailwind CSS
          "tailwindcss",
        },
        automatic_installation = true,
      })
    end,
  },

  -- https://github.com/neovim/nvim-lspconfig
  -- Configs for the Nvim LSP client
  { "neovim/nvim-lspconfig" },

  -- https://github.com/jay-babu/mason-null-ls.nvim
  -- mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        -- A list of sources to install if they're not already installed.
        -- This setting has no relation with the `automatic_installation` setting.
        ensure_installed = {
          'isort',
          -- 'mypy',
        },
        -- Run `require("null-ls").setup`.
        -- Will automatically install masons tools based on selected sources in `null-ls`.
        -- Can also be an exclusion list.
        -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
        automatic_installation = true,
        -- Whether sources that are installed in mason should be automatically set up in null-ls.
        -- Removes the need to set up null-ls manually.
        -- Can either be:
        -- 	- false: Null-ls is not automatically registered.
        -- 	- true: Null-ls is automatically registered.
        -- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
        -- 	Ex: { types = { eslint_d = {'formatting'} } }
        automatic_setup = false, -- Recommended, but optional
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.staticcheck,
          -- null_ls.builtins.diagnostics.semgrep,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.shellcheck,
          -- null_ls.builtins.diagnostics.pydocstyle,
          -- null_ls.builtins.diagnostics.pylint.with({
          --    diagnostics_postprocess = function(diagnostic)
          --        diagnostic.code = diagnostic.message_id
          --    end,
          -- }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rustfmt,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })

      require('mason-null-ls').setup_handlers() -- If `automatic_setup` is true.
    end,

  },

  -- https://github.com/glepnir/lspsaga.nvim
  -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI.
  -- Do make sure that your LSP plugins, like lsp-zero or lsp-config, are *loaded* before loading lspsaga.
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("lspsaga").setup({
        --            ui = {
        -- Currently, only the round theme exists
        --  theme = "round",
        -- This option only works in Neovim 0.9
        --  title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        --  border = "solid",
        --  winblend = 0,
        --  expand = "",
        --  collapse = "",
        --  preview = " ",
        --  code_action = "💡",
        --  diagnostic = "🐞",
        --  incoming = " ",
        --  outgoing = " ",
        --  hover = ' ',
        --  kind = {},
        -- },
        beacon = { enable = false, frequency = 7 },
      })

      local map = vim.keymap.set

      -- LSP finder - Find the symbol's definition
      -- If there is no definition, it will instead be hidden
      -- When you use an action in finder like "open vsplit",
      -- you can use <C-t> to jump back
      map("n", "<leader>jf", "<cmd>Lspsaga lsp_finder<CR>")

      -- Code action
      -- map({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

      -- Rename all occurrences of the hovered word for the entire file
      map("n", "<leader>jr", "<cmd>Lspsaga rename<CR>")

      -- Rename all occurrences of the hovered word for the selected files
      -- map("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

      -- Peek definition
      -- You can edit the file containing the definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      map("n", "<leader>je", "<cmd>Lspsaga peek_definition<CR>")

      -- Go to definition
      map("n", "<leader>jd", "<cmd>Lspsaga goto_definition<CR>")

      -- Toggle outline
      map("n", "<leader>jt", "<cmd>Lspsaga outline<CR>")

      -- Show line diagnostics
      -- You can pass argument ++unfocus to
      -- unfocus the show_line_diagnostics floating window
      -- map("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

      -- Show cursor diagnostics
      -- Like show_line_diagnostics, it supports passing the ++unfocus argument
      -- map("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

      -- Show buffer diagnostics
      -- map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

      -- Diagnostic jump
      -- You can use <C-o> to jump back to your previous location
      -- map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      -- map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

      -- Diagnostic jump with filters such as only jumping to an error
      -- map("n", "[E", function()
      --     require("lspsaga.diagnostic"):goto_prev({
      --         severity = vim.diagnostic.severity.ERROR,
      --     })
      -- end)
      -- map("n", "]E", function()
      --     require("lspsaga.diagnostic"):goto_next({
      --         severity = vim.diagnostic.severity.ERROR,
      --     })
      -- end)

      -- Hover Doc
      -- If there is no hover doc,
      -- there will be a notification stating that
      -- there is no information available.
      -- To disable it just use ":Lspsaga hover_doc ++quiet"
      -- Pressing the key twice will enter the hover window
      -- map("n", "K", "<cmd>Lspsaga hover_doc<CR>")

      -- If you want to keep the hover window in the top right hand corner,
      -- you can pass the ++keep argument
      -- Note that if you use hover with ++keep, pressing this key again will
      -- close the hover window. If you want to jump to the hover window
      -- you should use the wincmd command "<C-w>w"
      -- map("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

      -- Call hierarchy
      -- map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      -- map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

      -- Floating terminal
      -- map({ "n", "t" }, "<C-c>", "<cmd>Lspsaga term_toggle<CR>")
    end,
  },
}
