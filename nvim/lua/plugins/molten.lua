if vim.g.is_ssh then return {} end

return {
  {
    "lineick/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<localleader>mi", ":MoltenInit<CR>",                  mode = "n", silent = true, desc = "Initialize the plugin" },
      { "<localleader>mx", ":MoltenOpenInBrowser<CR>",         mode = "n", silent = true, desc = "Open output in browser" },
      { "<localleader>e",  ":MoltenEvaluateOperator<CR>",      mode = "n", silent = true, desc = "Run operator selection" },
      { "<localleader>rl", ":MoltenEvaluateLine<CR>",          mode = "n", silent = true, desc = "Evaluate line" },
      { "<localleader>rr", ":MoltenReevaluateCell<CR>",        mode = "n", silent = true, desc = "Re-evaluate cell" },
      { "<localleader>r",  ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", silent = true, desc = "Evaluate visual selection" },
      { "<localleader>md", ":MoltenDelete<CR>",                mode = "n", silent = true, desc = "Molten delete cell" },
      { "<localleader>mh", ":MoltenHideOutput<CR>",            mode = "n", silent = true, desc = "Molten hide output" },
      { "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", mode = "n", silent = true, desc = "Molten show/enter output" },
    },
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  }
}
