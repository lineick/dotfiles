if vim.g.is_ssh then return {} end -- deactivate this plugin per default
return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
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
