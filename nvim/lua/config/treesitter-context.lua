local treesitter_context = require("treesitter-context")

vim.keymap.set("n", "<leader>tc", function()
  treesitter_context.toggle()
end, { desc = "Toggle treesitter-context" })
