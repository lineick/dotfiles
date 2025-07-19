-- Manual Jumplist Manager for Neovim 0.10.0
-- Adds manual jumplist entries with <BS> key

local M = {}

-- Table to store manual jumplist entry positions
local manual_entries = {}

-- Get current cursor position
local function get_current_position()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return {
    bufnr = buf,
    lnum = cursor[1],
    col = cursor[2],
    filename = vim.api.nvim_buf_get_name(buf)
  }
end

-- Compare two positions for equality
local function positions_equal(pos1, pos2)
  return pos1.bufnr == pos2.bufnr and
      pos1.lnum == pos2.lnum
end

-- Get the current jumplist
local function get_jumplist()
  local jumplist = vim.fn.getjumplist()
  return jumplist[1], jumplist[2] -- jumps table and current index
end

-- Find the most recent manual entry in the jumplist
local function find_last_manual_entry_index()
  local jumps = get_jumplist()

  -- Search backwards through manual entries to find the most recent one in jumplist
  for i = #manual_entries, 1, -1 do
    local manual_pos = manual_entries[i]

    -- Search through jumplist to find this manual entry
    for j = 1, #jumps do
      local jump = jumps[j]
      if jump.bufnr == manual_pos.bufnr and
          jump.lnum == manual_pos.lnum and
          jump.col == manual_pos.col then
        print("Found manual entry in jumplist at index: " .. j)
        return j
      end
    end
  end

  return nil
end

-- Remove jumplist entries after a specific index
local function remove_entries_after_index(target_index)
  local jumps = get_jumplist()

  -- Keep entries up to and including the target index
  local entries_to_keep = {}
  for i = 1, target_index do
    if jumps[i] then
      table.insert(entries_to_keep, jumps[i])
    end
  end

  -- Clear and rebuild jumplist
  vim.cmd('clearjumps')

  local current_buf = vim.api.nvim_get_current_buf()
  local original_pos = vim.api.nvim_win_get_cursor(0)

  for _, jump in ipairs(entries_to_keep) do
    if vim.fn.bufexists(jump.bufnr) == 1 then
      vim.api.nvim_set_current_buf(jump.bufnr)
      vim.api.nvim_win_set_cursor(0, { jump.lnum, jump.col })
      vim.cmd('normal! m`')
    end
  end

  -- Return to original position
  vim.api.nvim_set_current_buf(current_buf)
  vim.api.nvim_win_set_cursor(0, original_pos)
end

-- Add manual jumplist entry
function M.add_manual_entry()
  local current_pos = get_current_position()

  -- Check if current position is same as last manual entry
  if #manual_entries > 0 then
    local last_manual = manual_entries[#manual_entries]
    if positions_equal(current_pos, last_manual) then
      print("Manual entry not added - position unchanged")
      return
    end
  end

  -- Check if a previous manual entry exists in the jumplist
  local last_manual_index = find_last_manual_entry_index()

  if last_manual_index then
    -- Remove all entries after the last manual entry
    remove_entries_after_index(last_manual_index)
  end

  -- Add current position to jumplist
  vim.cmd('normal! m`')

  -- Track this as a manual entry
  table.insert(manual_entries, current_pos)

  local filename = current_pos.filename ~= "" and
      vim.fn.fnamemodify(current_pos.filename, ":t") or
      "[No Name]"
  -- print("Manual entry added: " .. filename .. ":" .. current_pos.lnum)
end

-- Setup function
function M.setup(opts)
  opts = opts or {}
  local key = opts.key or '<BS>'

  vim.keymap.set('n', key, M.add_manual_entry, {
    desc = "Add manual jumplist entry",
    silent = true
  })

  -- Commands for debugging and management
  vim.api.nvim_create_user_command('AddManualJump', M.add_manual_entry, {
    desc = "Add a manual jumplist entry"
  })

  vim.api.nvim_create_user_command('ShowManualJumps', function()
    if #manual_entries == 0 then
      print("No manual jumplist entries")
      return
    end

    print("Manual jumplist entries:")
    for i, entry in ipairs(manual_entries) do
      local filename = entry.filename ~= "" and
          vim.fn.fnamemodify(entry.filename, ":t") or
          "[No Name]"
      print(string.format("%d: %s:%d:%d", i, filename, entry.lnum, entry.col))
    end
  end, {
    desc = "Show all manual jumplist entries"
  })

  vim.api.nvim_create_user_command('ClearManualJumps', function()
    manual_entries = {}
    print("Manual jumplist entries cleared")
  end, {
    desc = "Clear manual jumplist entries tracking"
  })
end

return M
