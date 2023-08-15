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
      require('dashboard').setup({
        theme = 'hyper',
        config = {
          packages = { enable = false },
          disable_move = true,
          shortcut = {
            { icon = '🍡 ', desc = 'Files', action = 'Telescope file_browser', key = 'F' },
            { icon = '🍥 ', desc = 'Configuration', action = 'Telescope dotfiles', key = 'C' },
            { icon = '', desc = '' },
          },
          project = { limit = 8, icon = '🍣 ', label = 'Projects', action = 'Telescope find_files cwd=' },
          mru = { limit = 10, icon = '🍤 ', label = 'Recently Files' },
          footer = {},
        },
        hide = {
          statusline = true, -- hide statusline default is true
          tabline = true, -- hide the tabline
          winbar = true, -- hide winbar
        },
        preview = {
          command = "chafa -s 80x80 -c full --fg-only --symbols braille --clear",
          file_path = "$(ls " .. os.getenv("HOME") .. "/.config/nvim/static/*.gif | sort -R)",
          file_height = 30,
          file_width = 80,
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

      -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings. Feel free to modify or remove as you wish.
        --
        -- BEGIN_DEFAULT_ON_ATTACH
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        -- END_DEFAULT_ON_ATTACH

        -- Mappings removed via:
        --   remove_keymaps
        --   OR
        --   view.mappings.list..action = ""
        --
        -- The dummy set before del is done for safety, in case a default mapping does not exist.
        --
        -- You might tidy things by removing these along with their default mapping.
        -- vim.keymap.set('n', 'O', '', { buffer = bufnr })
        -- vim.keymap.del('n', 'O', { buffer = bufnr })
        -- vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
        -- vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
        -- vim.keymap.set('n', 'D', '', { buffer = bufnr })
        -- vim.keymap.del('n', 'D', { buffer = bufnr })
        -- vim.keymap.set('n', 'E', '', { buffer = bufnr })
        -- vim.keymap.del('n', 'E', { buffer = bufnr })

        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        -- vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
        -- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        -- vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', 'P', function()
          local node = api.tree.get_node_under_cursor()
          print(node.absolute_path)
        end, opts('Print Node Path'))

        -- vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))

      end

      -- OR setup with some options
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
        on_attach = on_attach,
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
    enabled = false,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  },
}
