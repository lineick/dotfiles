if vim.g.is_ssh then return {} end
local gen = require('gen')

gen.setup({
  model = "qwen2.5-coder:7b-instruct", -- The default model to use.
  quit_map = "q",                      -- set keymap to close the response window
  retry_map = "<c-r>",                 -- set keymap to re-send the current prompt
  accept_map = "<c-cr>",               -- set keymap to replace the previous selection with the last result
  host = "localhost",                  -- The host running the Ollama service.
  port = "11434",                      -- The port on which the Ollama service is listening.
  display_mode = "vertical-split",     -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
  show_prompt = false,                 -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
  show_model = false,                  -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = false,               -- Never closes the window automatically.
  file = false,                        -- Write the payload to a temporary file to keep the command short.
  hidden = false,                      -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
  init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  -- Function to initialize Ollama
  command = function(options)
    local body = { model = options.model, stream = true }
    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
  end,
  -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- This can also be a command string.
  -- The executed command must return a JSON object with { response, context }
  -- (context property is optional).
  -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  result_filetype = "markdown", -- Configure filetype of the result buffer
  debug = false                 -- Prints errors and the command which is run.
})

gen.prompts['Explain'] = {
  prompt = "Explain what this $filetype code does:\n```$filetype\n$text\n```",
  model = "qwen2.5-coder:7b-instruct"
}
vim.keymap.set('v', '<leader>e', ':Gen Explain<CR>')
vim.keymap.set('v', '<leader>a', ':Gen Ask<CR>')

-- place the result split at the far right, a third of the screen wide
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "gen.nvim",
  callback = function()
    vim.cmd("wincmd L")
    vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
    -- result buffer wraps long lines; move over visual lines
    vim.keymap.set("n", "j", "gj", { buffer = true })
    vim.keymap.set("n", "k", "gk", { buffer = true })
  end,
})
