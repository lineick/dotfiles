local M = {}

function M.in_ssh()
  return vim.env.SSH_CONNECTION ~= nil
      or vim.env.SSH_CLIENT ~= nil
      or vim.env.SSH_TTY ~= nil
end

return M
