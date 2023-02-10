-- Monokai theme
local plugin = {
    "tanvirtin/monokai.nvim",
    config = function()
        -- We mostly turn the theme into molokai here.
        -- We should probably just create a real molokai theme at some
        -- point.
        local monokai = require("monokai")
        local palette = monokai.classic

        -- Colours that are close to molokai
        local molokai = {
            grey = "#1c1c1c",
            special_comment = "#8a8a8a",
            white = "#d0d0d0",
        }

        monokai.setup({
            custom_hlgroups = {
                Normal = {
                    fg = molokai.white,
                    bg = molokai.grey,
                },
                Constant = {
                    fg = "#ae81ff",
                    style = "bold",
                },
                CursorLineNr = {
                    fg = palette.orange,
                    bg = molokai.grey,
                },
                Delimiter = {
                    fg = palette.grey,
                },
                Identifier = {
                    fg = palette.orange,
                },
                Include = {
                    fg = palette.green,
                },
                LineNr = {
                    fg = palette.base5,
                    bg = molokai.grey,
                },
                Macro = {
                    fg = "#c4be89",
                    style = "italic",
                },
                SignColumn = {
                    fg = palette.white,
                    bg = molokai.grey,
                },
                Special = {
                    fg = "#66d9ef",
                    bg = "bg",
                    style = "italic",
                },
                SpecialComment = {
                    fg = molokai.special_comment,
                    style = "bold",
                },
                StatusLine = {
                    fg = palette.base7,
                    bg = molokai.grey,
                },
                StorageClass = {
                    fg = "#fd971f",
                    style = "italic",
                },
                String = {
                    fg = "#e6db74",
                },
            },
        })
    end,
}

return plugin
