-- if true then return {} end
-- stack is recommended for haken.nvim, easier to follow and more intuitive
-- vim.o.jumpoptions = "stack"

local haken = require("haken")

haken.setup({
  clear_jumplists = true,
  column_sensitive = true,
  clear_on_new_window = false,
})

vim.keymap.set('n', '<BS>', haken.add_haken, {
  desc = "Add haken",
  silent = true,
})

