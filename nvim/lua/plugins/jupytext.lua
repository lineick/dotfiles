if vim.g.is_ssh then return {} end

return {
  "GCBallesteros/jupytext.nvim",
  config = true,
  lazy=false,
}
