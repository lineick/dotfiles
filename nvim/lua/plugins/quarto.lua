if vim.g.is_ssh then return {} end

return {
  {
    "quarto-dev/quarto-nvim",
    ft = {"quarto", "markdown"},
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
