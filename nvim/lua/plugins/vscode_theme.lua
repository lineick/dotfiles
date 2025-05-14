return {
    {
        'Mofiqul/vscode.nvim',
        name = "vscode", -- This is equivalent to `as = "vscode"` in Packer
        config = function()
					local c = require('vscode.colors').get_colors()

					require('vscode').setup({
						-- color_overrides = {
						-- 	vscBack = '#011423',  -- Replace the background color with your desired color
						-- },
						transparent = true,
					})

					vim.cmd("colorscheme vscode")
        end,
    }
}

