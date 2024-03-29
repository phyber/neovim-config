-- File explorer
local plugin = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            renderer = {
                icons = {
                    show = {
                        file = false,
                    },
                },
            },
        })

        local keymap = require("keymap")
        keymap.nnoremap("<Leader>nt", ":NvimTreeToggle<CR>")
    end,
    keys = {
        {"<Leader>nt", desc = "Nvim Tree Toggle"},
    },
}

return plugin
