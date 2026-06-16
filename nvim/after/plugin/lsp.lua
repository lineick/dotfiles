-- nvim 0.11 default gr* lsp maps make gr ambiguous (timeoutlen wait on every press)
for _, lhs in ipairs({ "grr", "grn", "gra", "gri", "grt" }) do
  pcall(vim.keymap.del, "n", lhs)
end
pcall(vim.keymap.del, "x", "gra")


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
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>fl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '<leader>td', toggle_diagnostics, { desc = "Toggle diagnostics" })
end

-- run lsp_attach keymaps on every client attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    lsp_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
  end,
})

-- diagnostic signs in the gutter
if vim.o.signcolumn == 'auto' then
  vim.o.signcolumn = 'yes'
end
vim.diagnostic.config({ signs = true })

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'rust_analyzer', 'pyright', 'texlab' },
})

-- completion capabilities for all servers (merge cmp onto nvim defaults)
vim.lsp.config('*', {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  ),
})

-- mason-lspconfig v2 auto-enables installed servers; per-server overrides go
-- through vim.lsp.config (the handlers table is no longer honored)

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- tell Lua that 'vim' is a global variable
      },
    },
  },
})

vim.lsp.config('pyright', {
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
  handlers = {
    -- pyright sends rename edits with annotationId but omits the
    -- changeAnnotations map, tripping nvim 0.12's strict assert.
    -- strip the ids before applying. https://github.com/neovim/neovim/issues/34731
    [vim.lsp.protocol.Methods.textDocument_rename] = function(err, result, ctx)
      if err then
        vim.notify('pyright rename failed: ' .. err.message, vim.log.levels.ERROR)
        return
      end
      if not result then
        return
      end
      for _, change in ipairs(result.documentChanges or {}) do
        for _, edit in ipairs(change.edits or {}) do
          edit.annotationId = nil
        end
      end
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
    end,
  },
})

vim.lsp.config('texlab', {
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
        executable = "sioyek",
        args = {
          "--reuse-window",
          "--forward-search-file", "%f",
          "--forward-search-line", "%l",
          "%p",
        },
      },
      experimental = {
        snippetSupport = true, -- Ensure snippets are supported
      },
    },
  },
})
