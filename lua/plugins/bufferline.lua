-- Buffer tabs
local plugin = {
    "akinsho/bufferline.nvim",
    config = function()
        require("bufferline").setup({
            options = {
                buffer_close_icon = "x",
                close_icon = "x",
                diagnostics = "nvim_lsp",
                numbers = "ordinal",
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,

                indicator = {
                    style = "none",
                },

                separator_style = {
                    '|',
                    '|',
                },

                -- show_buffer_default_icon was deprecated. Maybe this is
                -- equivalent, who knows?
                get_element_icon = function(_bufnr)
                    return false
                end,
            },
        })
    end,
}

return plugin
