require("nvim-treesitter").install({
  "bash", "bibtex", "c", "cpp", "css", "csv", "desktop", "diff", "dockerfile",
  "git_config", "git_rebase", "gitcommit", "gitignore", "glsl", "html",
  "javascript", "json", "latex", "lua", "make", "markdown", "markdown_inline",
  "perl", "python", "query", "requirements", "rst", "rust", "ssh_config",
  "tmux", "toml", "vim", "vimdoc", "xml", "yaml",
})

-- main branch enables nothing by default; start highlight and (experimental)
-- indent per buffer wherever a parser exists
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
