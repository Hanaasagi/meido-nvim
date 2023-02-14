return {
  -- https://github.com/dstein64/vim-startuptime
  -- vim-startuptime is a plugin for viewing vim and nvim startup event timing information.
  { "dstein64/vim-startuptime" },

  -- https://github.com/wakatime/vim-wakatime
  -- WakaTime is an open source Vim plugin for metrics, insights, and time tracking automatically generated from your programming activity.
  { "wakatime/vim-wakatime" },

  -- https://github.com/glepnir/dashboard-nvim
  -- Fancy and Blazing Fast start screen plugin of neovim
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local width = vim.api.nvim_win_get_width(0)
      require('dashboard').setup({
        theme = 'hyper',
        config = {
          disable_move = true,
          shortcut = {
            { icon = '🍡 ', icon_hl = '@variable', desc = 'Files', action = 'Telescope file_browser', key = 'f' },
            { icon = '🍥 ', icon_hl = '@variable', desc = 'Configuration', action = 'Telescope dotfiles', key = 'd' },
          },
        },
        hide = {
          statusline = true, -- hide statusline default is true
          tabline = true, -- hide the tabline
          winbar = true, -- hide winbar
        },
        preview = {
          command = "chafa -s 60x60 -c full --fg-only --symbols braille --clear",
          file_path = "$(ls " .. os.getenv("HOME") .. "/.config/nvim/static/*.gif | sort -R)",
          file_height = 30,
          file_width = 60,
        },
      })
    end,

  },

  -- https://github.com/nvim-tree/nvim-tree.lua
  -- A File Explorer For Neovim Written In Lua
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- empty setup using defaults
      require("nvim-tree").setup()

      -- OR setup with some options
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30, mappings = { list = { { key = "u", action = "dir_up" } } } },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
      })
    end,

  },

  -- https://github.com/ahmedkhalf/project.nvim
  -- project.nvim is an all in one neovim plugin written in lua that provides superior project management.
  {
    "ahmedkhalf/project.nvim",
    config = function()
      local project = require('project_nvim')
      project.setup({ exclude_dirs = { '*//*' }, detection_methods = { 'pattern' }, patterns = { '.git' } })
    end,

  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  },
}
