return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,       -- disable inline UI
        auto_trigger = true,  -- copilot-cmp handles this
        keymap = {
          accept = "<Right>",
          -- accept_word = "<C-w>",
          accept_line = "<S-Tab>", -- line acceptance
        },
      },
      panel = { enabled = true },
    })
  end,
}
