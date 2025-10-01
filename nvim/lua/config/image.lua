if vim.g.is_ssh then return {} end

require("image").setup({
  backend = "kitty", -- Kitty will provide the best experience, but you need a compatible terminal
  integrations = {}, -- do whatever you want with image.nvim's integrations
  max_width = 100,
  max_height = 12,
  max_height_window_percentage = math.huge, -- this is necessary for a good experience
  max_width_window_percentage = math.huge,
  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
})
