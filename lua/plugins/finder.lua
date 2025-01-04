return {
  -- {"stevearc/dressing.nvim"},

  -- https://github.com/kevinhwang91/rnvimr
  -- {"kevinhwang91/rnvimr"},

  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  -- fzf-native is a c port of fzf.
  -- It only covers the algorithm and implements few functions to support calculating the score.
  { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },

  -- https://github.com/nvim-telescope/telescope-file-browser.nvim
  -- telescope-file-browser.nvim is a file browser extension for telescope.nvim.
  -- It supports synchronized creation, deletion, renaming,
  -- and moving of files and folders powered by telescope.nvim and plenary.nvim.
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { 'nvim-telescope/telescope.nvim' } },

  -- https://github.com/nvim-telescope/telescope-media-files.nvim
  -- Preview images, pdf, epub, video, and fonts from Neovim using Telescope.
  -- WARN: There some bugs in my archlinux laptop
  -- {
  -- "nvim-telescope/telescope-media-files.nvim",
  -- dependencies = { 'nvim-telescope/telescope.nvim' },

  -- },

  -- https://github.com/nvim-telescope/telescope-ui-select.nvim
  -- It sets vim.ui.select to telescope.
  -- That means for example that neovim core stuff can fill the telescope picker.
  -- Example would be lua vim.lsp.buf.code_action().
  { "nvim-telescope/telescope-ui-select.nvim", dependencies = { 'nvim-telescope/telescope.nvim' } },

  -- https://github.com/nvim-telescope/telescope.nvim
  -- telescope.nvim is a highly extendable fuzzy finder over lists.
  -- Built on the latest awesome features from neovim core.
  -- Telescope is centered around modularity, allowing for easy customization.
  {

    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          -- selection_caret = " ",
          selection_caret = "> ",
          entry_prefix = "  ",
          border = true,
          -- borderchars = { ' ', '│', '─', '│', ' ', ' ', '╯', '╰' },
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = { prompt_position = 'top', preview_width = 0.55, results_width = 0.8 },
            vertical = { mirror = false },
            width = 0.8,
            height = 0.80,
            preview_cutoff = 120,
          },
          --
          -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
          mappings = {
            i = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous", ["<C-c>"] = "close" },
            n = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous", ["<C-c>"] = "close" },
          },
        },
        extensions = {
          -- TODO: This is not configured
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
        pickers = { colorscheme = { enable_preview = true } },
      })

      local builtin = require('telescope.builtin')
      local map = vim.keymap.set

      -- https://github.com/nvim-telescope/telescope.nvim#pickers
      map('n', '<leader>ff', builtin.find_files, { noremap = true, desc = "invoke telescope find_files picker" })
      map('n', '<leader>fb', builtin.buffers, { noremap = true, desc = "invoke telescope buffer picker" })
      map('n', '<leader>fg', builtin.live_grep, { noremap = true, desc = "invoke telescope live_grep picker" })
      map('n', '<leader>fh', builtin.help_tags, { noremap = true, desc = "invoke telescope help_tags picker" })
      map("n", "<leader>fd", ":Telescope file_browser<CR>",
          { noremap = true, desc = "invoke telescope file_browser picker" })

      require("telescope").load_extension("ui-select")
      require('telescope').load_extension('fzf')
      require("telescope").load_extension("file_browser")
      require('telescope').load_extension('projects')
      require("telescope").load_extension("noice")
      -- require'telescope'.extensions.projects.projects{}
    end,

  },

}
