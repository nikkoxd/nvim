-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Window navigation prefix
vim.keymap.set("n", "<leader>w", "<C-w>", { noremap = true })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Remap Ctrl+hjkl for moving between windows (panes)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left pane" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to down pane" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to up pane" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right pane" })

vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca ц w")
vim.cmd("ca й q")
vim.cmd("ca Ц w")
vim.cmd("ca Й q")
vim.cmd("ca WQ wq")
vim.cmd("ca Wq wq")
vim.cmd("ca цй wq")
