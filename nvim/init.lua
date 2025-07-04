vim.loader.enable()     -- native Lua module cache

-- set ssh flag to adjust config
vim.g.is_ssh = require("util.env").in_ssh()

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("config")
require("autoclose").setup()
if not vim.g.is_ssh then
  require("luasnip.loaders.from_snipmate").load() -- moved from the bottom, make sure still works
end

-- basic stuff
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.breakindent = true
vim.opt.updatetime = 250

-- yank via OSC52 (so + register works on remote machines)
-- requires osc52 support in the terminal (works for kitty)
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- for oil previews opening to the right instead of left
vim.opt.splitright = true

-- Making option + backspace work as "delete previuos word"
vim.keymap.set('i', '<M-BS>', "<C-W>")

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- highlight search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.scrolloff = 10

-- Allow search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Colorscheme
vim.cmd.colorscheme "vscode"
