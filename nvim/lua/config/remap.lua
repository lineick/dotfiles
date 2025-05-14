vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- Window movement
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, desc = "Move to left window" })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, desc = "Move to window below" })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, desc = "Move to window above" })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, desc = "Move to right window" })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, desc = "Escape terminal mode in vim" })

-- To change the size of the split in 15 point intervals
vim.keymap.set('n', '<leader>o', '15<C-w>>', { noremap = true, desc = "Make current window larger horizontally" })
vim.keymap.set('n', '<leader>y', '15<C-w><', { noremap = true, desc = "Make current window smaller horizontally" })
vim.keymap.set('n', '<leader>i', '7<C-w>+', { noremap = true, desc = "Make current window larger vertically" })
vim.keymap.set('n', '<leader>u', '7<C-w>-', { noremap = true, desc = "Make current window smaller vertically" })

-- Swap window positions
vim.keymap.set('n', '<leader>s', '<C-w>r', { noremap = true, desc = "Swap window positions" })
