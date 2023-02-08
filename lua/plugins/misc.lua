return {
  -- https://github.com/dstein64/vim-startuptime
  -- vim-startuptime is a plugin for viewing vim and nvim startup event timing information.
  { "dstein64/vim-startuptime" },

  -- https://github.com/wakatime/vim-wakatime
  -- WakaTime is an open source Vim plugin for metrics, insights, and time tracking automatically generated from your programming activity.
  { "wakatime/vim-wakatime" },

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
