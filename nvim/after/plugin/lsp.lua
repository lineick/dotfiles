local lsp_zero = require("lsp-zero")


-- Functionality for toggling diagnostics (inline errors etc.)
local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  else
    vim.diagnostic.disable()
    print("Diagnostics disabled")
  end
end


local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>dgk', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '<leader>dgt', toggle_diagnostics, { desc = "Toggle diagnostics" })
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = { 'lua_ls', 'rust_analyzer', 'pyright', "texlab" },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        on_attach = lsp_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }, -- tell Lua that 'vim' is a global variable
            },
          },
        },
      })
    end,

    pyright = function()
      require('lspconfig').pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
        on_attach = lsp_attach, -- Attach custom keymaps
      })
    end,
    texlab = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      require('lspconfig').texlab.setup({
        capabilities = capabilities,
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = true,
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = true,
            },
            forwardSearch = {
              executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
              args = { "%l", "%f", "%p" }, -- Line, file, and PDF file
            },
            experimental = {
              snippetSupport = true, -- Ensure snippets are supported
            },
          },
        },
      })
    end,
  }
})
