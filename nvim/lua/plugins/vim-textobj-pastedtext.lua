return {
  "saaguero/vim-textobj-pastedtext",
  dependencies = {"kana/vim-textobj-user"},
  config = function()
    vim.g.pastedtext_select_key = "gb"
  end
}
