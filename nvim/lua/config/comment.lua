local comment_api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- line comment
vim.keymap.set("n", "<C-Space>",
  function()
    comment_api.toggle.linewise.current()
  end, { noremap = true, silent = true, desc = "Toggle comment linewise" }
)
-- visual mode comment
vim.keymap.set('x', '<C-Space>',
  function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    comment_api.toggle.linewise(vim.fn.visualmode())
  end, { desc = "Toggle comment visual mode" }
)
