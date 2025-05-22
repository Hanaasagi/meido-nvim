local _M = {}

function _M.setup()
  -- load builtin configs
  require("builtin")

  -- load plugin manager
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    print("installing lazy.nvim...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
    print("installing lazy.nvim...done")
  end
  vim.opt.rtp:prepend(lazypath)

  -- load plugins, auto import lua/plugins files
  require("lazy").setup({ { import = "plugins" } })
end

_M.setup()
