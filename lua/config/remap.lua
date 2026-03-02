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
