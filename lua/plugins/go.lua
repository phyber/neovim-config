-- Go
local plugin = {
    "ray-x/go.nvim",
    build = function()
        require("go.install").update_all_sync()
    end,
    config = function()
        require("go").setup()

        local group = vim.api.nvim_create_augroup("goimports", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            pattern = "*.go",
            callback = function()
                require("go.format").goimports()
            end,
        })
    end,
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "ray-x/guihua.lua",
    },
    event = {
        "CmdlineEnter",
    },
    ft = {
        "go",
        "gomod",
    },
}

return plugin
