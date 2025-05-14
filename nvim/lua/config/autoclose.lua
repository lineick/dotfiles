require("autoclose").setup({
  keys = {
    ["'"] = { escape = true, close = false, pair = "''"},
  },
  options = {
    disable_when_touch = true,
    disable_command_mode = true
  }
})
