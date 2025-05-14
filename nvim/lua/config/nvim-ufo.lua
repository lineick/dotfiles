vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds with ufo" })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds with ufo" })

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})
