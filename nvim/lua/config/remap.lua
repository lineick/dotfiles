vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function() require("oil").open_float() end, { desc = "Open Oil file manager" })

-- Window movement
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, desc = "Move to left window" })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, desc = "Move to window below" })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, desc = "Move to window above" })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, desc = "Move to right window" })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, desc = "Escape terminal mode in vim" })

-- To change the size of the split in 15 point intervals
vim.keymap.set('n', '<leader><leader>o', '15<C-w>>', { noremap = true, desc = "Make current window larger horizontally" })
vim.keymap.set('n', '<leader><leader>y', '15<C-w><', { noremap = true, desc = "Make current window smaller horizontally" })
vim.keymap.set('n', '<leader><leader>i', '7<C-w>+', { noremap = true, desc = "Make current window larger vertically" })
vim.keymap.set('n', '<leader><leader>u', '7<C-w>-', { noremap = true, desc = "Make current window smaller vertically" })

-- Swap window positions
vim.keymap.set('n', '<leader>s', '<C-w>r', { noremap = true, desc = "Swap window positions" })

-- paste over visual selection without losing it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- move highlighted text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the same position when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle position when scrolling and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- indent paragraph while keeping cursor in the same position
vim.keymap.set("n", "=ap", "ma=ap'a")

--diagnostics next
vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)

-- FREE KEYS
vim.keymap.set("n", "Q", "", { noremap = true, desc = "Key not used" })

-- remove select mode
vim.keymap.set("n", "gh", "", { noremap = true, desc = "Key not used (no select mode)" })
