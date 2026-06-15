require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
  move = { set_jumps = false },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

-- code cells (see after/queries/markdown/textobjects.scm)
vim.keymap.set({ "x", "o" }, "ib", function()
  select.select_textobject("@code_cell.inner", "textobjects")
end, { desc = "in block" })
vim.keymap.set({ "x", "o" }, "ab", function()
  select.select_textobject("@code_cell.outer", "textobjects")
end, { desc = "around block" })

vim.keymap.set({ "n", "x", "o" }, "]b", function()
  move.goto_next_start("@code_cell.inner", "textobjects")
end, { desc = "next code block" })
vim.keymap.set({ "n", "x", "o" }, "[b", function()
  move.goto_previous_start("@code_cell.inner", "textobjects")
end, { desc = "previous code block" })

vim.keymap.set("n", "<leader>sbl", function()
  swap.swap_next("@code_cell.outer")
end, { desc = "swap code block with next" })
vim.keymap.set("n", "<leader>sbh", function()
  swap.swap_previous("@code_cell.outer")
end, { desc = "swap code block with previous" })
