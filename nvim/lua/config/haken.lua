-- stack is recommended for haken.nvim, easier to follow and more intuitive
vim.o.jumpoptions = "stack"

local haken = require("haken")

haken.setup({
  clear_jumplist = true,
  column_sensitive = true,
})

vim.keymap.set('n', '<BS>', haken.add_haken, {
  desc = "Add haken",
  silent = true,
})

