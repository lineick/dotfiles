-- if true then return {} end
-- vim.o.jumpoptions = "stack"

local haken = require("haken")

haken.setup({
  clear_jumps_on_startup = true,
  column_sensitive = false,
  clear_jumps_on_new_window = false,
  silent = false,
})

-- using jumpoptions=stack is not recommended with add_haken(false), can lead to confusing behavior
vim.keymap.set('n', '<BS>', haken.add_haken, {
  desc = "Add haken",
  silent = true,
})

vim.keymap.set('n', '<leader><BS>', haken.prune_jumps, {
  desc = "Prune jumps to most recent jump",
  silent = true,
})

-- vim.keymap.set('n', '<C-o>', function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>', true, false, true), 'nx', false)
--   haken.set_recent_haken()
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set('n', '<C-i>', function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-i>', true, false, true), 'nx', false)
--   haken.set_recent_haken()
-- end, { noremap = true, silent = true })
--
