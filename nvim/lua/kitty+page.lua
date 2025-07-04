return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
	-- print("INPUT_LINE_NUMBER:", INPUT_LINE_NUMBER, "CURSOR_LINE:", CURSOR_LINE, "CURSOR_COLUMN:", CURSOR_COLUMN)
	vim.opt.encoding = "utf-8"
	vim.opt.clipboard = "unnamedplus"
	vim.opt.compatible = false
	vim.opt.number = false
	vim.opt.relativenumber = false
	vim.opt.termguicolors = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.opt.showmode = true
	vim.opt.ruler = false
	vim.opt.laststatus = 0
	vim.opt.showcmd = false
	vim.opt.scrollback = 100000
	-- use the visual color matching the current colorscheme
	vim.cmd("hi Normal ctermbg=None ctermfg=None guibg=None guifg=None")
	vim.cmd("set cmdheight=0")
	vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")
	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("n", "<C-u>", "<C-u>zz")
	vim.keymap.set("n", "n", "nzzzv")
	vim.keymap.set("n", "N", "Nzzzv")
	local term_buf = vim.api.nvim_create_buf(true, false)

  -- copy command with yy
  local function yank_command_only()
    local current_line = vim.api.nvim_get_current_line()

    -- 1. Strip the prompt: everything up to (and including) the first
    --    “$” or “»”, plus the single space that follows.
    current_line = current_line:gsub("^.-[%$»]%s+", "")

    -- 2. Strip the suffix: anything that’s separated from the command
    --    by two or more consecutive whitespace characters.
    current_line = current_line:gsub("%s%s+.*$", "")

    vim.fn.setreg("+", current_line)
    vim.highlight.on_yank()

    -- close the terminal buffer
    vim.schedule(function ()
      vim.cmd("quit")
    end)
  end

  vim.api.nvim_buf_set_keymap(term_buf, 'n', 'yy', '', {
    noremap = true,
    callback = yank_command_only,
    desc = 'Yank only the command without shell prompt symbols',
  })

  vim.api.nvim_buf_set_keymap(term_buf, 'n', 'q', '', {
    noremap   = true,
    callback  = function()
      vim.schedule(function() vim.cmd('quit') end)
    end,
    desc      = 'Close this scratch buffer',
  })

	local term_io = vim.api.nvim_open_term(term_buf, {})
	vim.api.nvim_buf_set_keymap(term_buf, "n", "q", "<Cmd>q<CR>", {})
	local group = vim.api.nvim_create_augroup("kitty+page", {})

	local setCursor = function()
		vim.api.nvim_feedkeys(tostring(INPUT_LINE_NUMBER) .. [[ggzt]], "n", true)
		local line = vim.api.nvim_buf_line_count(term_buf)
		if CURSOR_LINE <= line then
			line = CURSOR_LINE
		end
		line = CURSOR_LINE
		vim.api.nvim_feedkeys(tostring(line - 1) .. [[j]], "n", true)
		vim.api.nvim_feedkeys([[0]], "n", true)
		vim.api.nvim_feedkeys(tostring(CURSOR_COLUMN - 1) .. [[l]], "n", true)
	end

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = group,
		buffer = term_buf,
		callback = function()
			local mode = vim.fn.mode()
			if mode == "t" then
				vim.cmd.stopinsert()
				vim.schedule(setCursor)
			end
		end,
	})

	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		pattern = "*",
		once = true,
		callback = function(ev)
			local current_win = vim.fn.win_getid()
			for _, line in ipairs(vim.api.nvim_buf_get_lines(ev.buf, 0, -2, false)) do
				vim.api.nvim_chan_send(term_io, line)
				vim.api.nvim_chan_send(term_io, "\r\n")
			end
			for _, line in ipairs(vim.api.nvim_buf_get_lines(ev.buf, -2, -1, false)) do
				vim.api.nvim_chan_send(term_io, line)
			end
			vim.api.nvim_win_set_buf(current_win, term_buf)
			vim.api.nvim_buf_delete(ev.buf, { force = true })
		end,
	})

	local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = "*",
	})

	vim.defer_fn(setCursor, 10)
end
