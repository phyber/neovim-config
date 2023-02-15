-- Replacement notices UIs
local plugin = {
    "folke/noice.nvim",
    cond = function()
        return require("util").nvim_has("nvim-0.9")
    end,
    config = function()
        require("noice").setup({
            cmdline = {
                view = "cmdline_popup",
                format = {
                    cmdline = {
                        icon = ">",
                    },
                    help = {
                        icon = "?",
                    },
                    lua = {
                        icon = "lua>",
                    },
                    search_down = {
                        icon = "/",
                    },
                    search_up = {
                        icon = "/",
                    },
                },
            },
            override = {
                ["cmp.entry.get_documentation"] = true,
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            popupmenu = {
                kind_icons = false,
            },
            presets = {
                bottom_search = true,
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}

return plugin
