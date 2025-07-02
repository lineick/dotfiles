-- must be set globally but is used by quickscope ONLY
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_hi_priority = 2
vim.g.qs_max_chars = 180

-- Equivalent of the qs_colors augroup and ColorScheme autocmds
vim.api.nvim_create_augroup("qs_colors", { clear = true })
-- instead of colors use the search markers
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "qs_colors",
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "QuickScopePrimary",
      { link = "IncSearch" })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary",
      { link = "Search" })
  end,
})

return {
  "unblevable/quick-scope",
  event = "VeryLazy",
}
