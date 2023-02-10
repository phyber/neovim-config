-- Treesitter
-- Remember to install parsers with :TSInstall <language>, check what's
-- already installed with :TSInstallInfo
local plugin = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cond = function()
        local util = require "util"

        return util.nvim_has("nvim-0.6")
    end,
    config = function()
        -- We only want to be enabled for specific languages, but
        -- Treesitter makes this a bit of a chore.
        -- This table will be checked in the highlight.disable
        -- function.
        local highlight_ft_enabled = {
            markdown = true,
        }

        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,

                -- We're also passed the bufnr as an argument here, but
                -- we don't need that.
                disable = function(lang)
                    local disabled = not highlight_ft_enabled[lang]

                    return disabled
                end,
            },

            -- Enable p00f/nvim-ts-rainbow
            rainbow = {
                enable = true,
                extended_mode = false,
            },
        })
    end,
    dependencies = {
        "p00f/nvim-ts-rainbow",
    },
}

return plugin
