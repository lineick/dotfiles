require("config")
require("autoclose").setup()
require("luasnip.loaders.from_snipmate").load() -- moved from the bottom, make sure still works

-- basic stuff
vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.breakindent = true
vim.opt.updatetime = 250

-- Making option + backspace work as "delete previuos word"
vim.keymap.set('i', '<M-BS>', "<C-W>")

-- Adding line numbers in netrw
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- highlight search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.scrolloff = 10
vim.opt.colorcolumn = "95"

-- These options are handled by the neoscroll plugin now
vim.opt.scroll = 15

-- Allow search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
