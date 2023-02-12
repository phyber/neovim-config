local plugin = {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.cmd("highlight IndentBlanklineIndent1 guibg=#23272e gui=nocombine")

        require("indent_blankline").setup({
            char = " ",

            char_highlight_list = {
                "IndentBlanklineIndent1",
            },
        })
    end,
}

return plugin
