if vim.g.is_ssh then return {} end -- deactivate this plugin per default
return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false, -- activate again when subscription exist
        auto_trigger = true,
        keymap = {
          accept = "<Right>",
          accept_line = "<S-Tab>", -- line acceptance
        },
      },
      panel = { enabled = true },
    })
  end,
}
