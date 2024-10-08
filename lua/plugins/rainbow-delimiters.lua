-- Rainbow brackets
local plugin = {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    config = function()
        require("rainbow-delimiters.setup").setup({})
    end,
}

return plugin
