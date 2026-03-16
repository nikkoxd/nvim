vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.cmdheight = 0

vim.opt.autoread = true
vim.opt.swapfile = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.concealcursor = 'vic'

vim.opt.fillchars = {
  vert = "│",
  fold = " ",
  eob = " ",
  diff = "░",
  msgsep = "‾",
  foldopen = "",
  foldsep = " ",
  -- foldinner = " ",
  foldclose = "",
}

vim.diagnostic.config({
  underline = true,
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "󰟃",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
  virtual_text = false,
  float = {
    border = "single",
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
})
