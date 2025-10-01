if vim.g.is_ssh then return {} end

return {
  "3rd/image.nvim",
  -- version = "1.1.0",
  build = false,   -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = "magick_cli",
  }
}
