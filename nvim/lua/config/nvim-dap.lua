local dap = require('dap')

-- Adapter for Python (debugpy)
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
			-- Adds virtualenv if possible
			local venv_path = os.getenv("VIRTUAL_ENV")
      if venv_path then
        return venv_path .. '/bin/python'
      end
      return '/Users/jarl/.pyenv/shims/python'

    end;
  },
}

-- Adapter for Rust
dap.adapters.lldb = {
    type = "server",
    port = "${port}", -- DAP will automatically choose a free port
    executable = {
        command = "/Users/jarl/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
    },
}
dap.configurations.rust = {
    {
        name = "main",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/rust-minimax"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
require('dap').set_log_level('TRACE')

-- Allowing logging of dap
vim.g.dap_debug_log = true

vim.fn.sign_define('DapBreakpoint', { text='◆', texthl='', linehl='', numhl='' })

vim.api.nvim_set_keymap('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { noremap = true, silent = true })

-- Open Read-Eval-Print Loop (essentially debug console)
vim.api.nvim_set_keymap('n', '<Leader>dc', "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

-- Rerun session
vim.api.nvim_set_keymap('n', '<Leader>rr', "<Cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })

-- Terminate session
vim.keymap.set('n', '<Leader>dq', function()
  require('dap').terminate()
end)

-- Hover functionality - shows some information about values
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)

-- Preview functionality - shows more in-depth information about values
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)

-- Showing the call stack 
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)

-- Showing the variable scopes
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
