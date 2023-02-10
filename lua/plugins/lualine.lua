-- Status bar
local plugin = {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = false,
                theme = "material",

                -- Disable for certain filetypes
                disabled_filetypes = {
                    statusline = {
                        "alpha",
                        "lazy",
                    },
                },

                -- No fancy separators, not all terminals have the
                -- rights fonts.
                component_separators = {
                    left = nil,
                    right = nil,
                },
                section_separators = {
                    left = nil,
                    right = nil,
                },
            },
        })
    end,
}

return plugin
