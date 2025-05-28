local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<leader>pr', builtin.resume, { desc = "Open previous telescope search" })
vim.keymap.set('n', '<leader>pl', builtin.live_grep, { desc = "Search for file contents live (ripgrep)" })

vim.keymap.set('n', '<leader>pb', function()
  builtin.buffers({ sort_mru = true })
end, { desc = "Open buffers" })

-- Search for occurences in files
vim.keymap.set('n', '<leader>ps',
  function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
  end,
  { desc = "Search grep string" }
)
