if vim.g.is_ssh then return {} end

return {
  'jmbuhr/otter.nvim',
  lazy=true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
}
