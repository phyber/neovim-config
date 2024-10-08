local plugin = {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")
        local GLOBAL_HIGHLIGHT_GROUP = 0

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(
                GLOBAL_HIGHLIGHT_GROUP,
                "IndentBlanklineIndent1", {
                    bg = "#23272e",
                }
            )
        end)

        ibl.setup({
            indent = {
                char = " ",
                highlight = {
                    "IndentBlanklineIndent1",
                },
            },
            scope = {
                enabled = false,
            },
        })
    end,
}

return plugin
