local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- conform will run multiple formatters sequentially
    python = { "isort", "ruff_format" },
    -- you can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    latex = { "latexindent" },
  },
  formatters = {
    black = { prepend_args = { "--line-length", "95" } }
  }
})

vim.keymap.set({"n", "x"}, "<leader>fmt", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  })
end, { desc = "format file current file with 'conform' plugin" }
)
