local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
  { desc = "Harpoon: Add current file" }
)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = "Harpoon: Open Harpoon menu" }
)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Go to Harpoon 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Go to Harpoon 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Go to Harpoon 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Go to Harpoon 4" })
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Go to Harpoon 5" })
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Go to Harpoon 6" })
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "Go to Harpoon 7" })
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "Go to Harpoon 8" })
