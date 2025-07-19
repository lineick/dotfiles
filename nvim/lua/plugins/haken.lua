return {
  "haken.nvim",
  dev = true,
  config = function()
    require("haken").setup({
      key = "<BS>",
      silent = false,
    })
  end,
}
