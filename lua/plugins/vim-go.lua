-- Vim syntax highlighting, formatting on save, etc.
local plugin = {
    "fatih/vim-go",
    enabled = false,
    ft = "go",
    init = function()
        vim.g.go_fmt_autosave = 1
        vim.g.go_fmt_command = "goimports"
    end,
}

return plugin
