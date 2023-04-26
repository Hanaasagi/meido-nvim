vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "set tabstop=4 shiftwidth=4 softtabstop=4 expandtab colorcolumn=80 ai",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby,lua,javascript,html,css,xml,typescript,markdown",
  command = "set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "set tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=120 ai",
})
