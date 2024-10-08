-- Treesitter
-- Remember to install parsers with :TSInstall <language>, check what's
-- already installed with :TSInstallInfo
local plugin = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    tag = "v0.9.2",
    cond = function()
        return require("util").nvim_has("nvim-0.6")
    end,
    config = function()
        -- We only want to be enabled for specific languages, but
        -- Treesitter makes this a bit of a chore.
        -- This table will be checked in the highlight.disable
        -- function.
        local highlight_ft_enabled = {
            javascript = true,
            markdown = true,
        }

        -- Do a synchronous install on a Raspberry Pi so we don't kill the
        -- system.
        local sync_install = require("machine").is_raspberry_pi()

        require("nvim-treesitter.configs").setup({
            sync_install = sync_install,

            ensure_installed = {
                "bash",
                "javascript",
                "lua",
                "markdown",
                "markdown_inline",
                "regex",
                "rust",
                "vim",
                "vimdoc",
            },

            highlight = {
                enable = true,

                -- We're also passed the bufnr as an argument here, but
                -- we don't need that.
                disable = function(lang)
                    local disabled = not highlight_ft_enabled[lang]

                    return disabled
                end,
            },
        })
    end,
}

return plugin
