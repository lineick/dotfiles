if vim.g.is_ssh then return {} end

local jupytext = require("jupytext")

jupytext.setup({
    style = "markdown",
    output_extension = "md",
    force_ft = "markdown",
})
