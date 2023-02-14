-- Buffer tabs
local plugin = {
    "akinsho/bufferline.nvim",
    config = function()
        require("bufferline").setup({
            options = {
                buffer_close_icon = "x",
                close_icon = "x",
                diagnostics = "nvim_lsp",
                numbers = "buffer_id",
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_buffer_default_icon = false,
                show_close_icon = false,

                indicator = {
                    style = "none",
                },

                separator_style = {'|', '|'},
            },
        })
    end,
}

return plugin
