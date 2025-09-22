if vim.g.is_ssh then return {} end
local M = {}

function M.setup()
  -- Global settings
  vim.g.magma_automatically_open_output = false
  vim.g.magma_image_provider = "kitty"

  -- Keymaps
  local map, opts = vim.keymap.set, { silent = true }
  map("n", "<LocalLeader>r", function() return ":MagmaEvaluateOperator<CR>" end,
      vim.tbl_extend("force", opts, { expr = true }))
  map("n", "<LocalLeader>rr", ":MagmaEvaluateLine<CR>", opts)
  map("x", "<LocalLeader>r",  ":<C-u>MagmaEvaluateVisual<CR>", opts)
  map("n", "<LocalLeader>rc", ":MagmaReevaluateCell<CR>", opts)
  map("n", "<LocalLeader>rd", ":MagmaDelete<CR>", opts)
  map("n", "<LocalLeader>ro", ":MagmaShowOutput<CR>", opts)

  -- Init helpers
  local function MagmaInitPython()
    vim.cmd([[
      :MagmaInit python3
      :MagmaEvaluateArgument a=5
    ]])
  end

  local function MagmaInitCSharp()
    vim.cmd([[
      :MagmaInit .net-csharp
      :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof(System.Object),"text/plain");
    ]])
  end

  local function MagmaInitFSharp()
    vim.cmd([[
      :MagmaInit .net-fsharp
      :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof<System.Object>,"text/plain")
    ]])
  end

  -- User commands
  vim.api.nvim_create_user_command("MagmaInitPython", MagmaInitPython, {})
  vim.api.nvim_create_user_command("MagmaInitCSharp", MagmaInitCSharp, {})
  vim.api.nvim_create_user_command("MagmaInitFSharp", MagmaInitFSharp, {})
end

return M

