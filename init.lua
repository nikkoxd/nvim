require("remap")

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local gdproject = io.open(vim.fn.getcwd().."/project.godot", "r")
if gdproject then
    io.close(gdproject)
    vim.fn.serverstart "/tmp/godot.pipe"
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.cmdheight = 0

vim.g.netrw_list_hide = [[.meta,.DS_Store]]

require("lazy").setup("plugins")
