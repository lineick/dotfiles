local surround = require("nvim-surround")

surround.setup({
  keymaps = {
    normal = "s",
    normal_cur = "ss",
    normal_line = "S",
    visual = "s",
    visual_line = "S",
  }
})
