-- autocmds
local util = require "util"
local api = vim.api
local fn = vim.fn

util.create_augroups({
    vimrcEx = {
        -- "filetype plugin indent on" is set by default for neovim
        -- For all text files set width to 78 characters
        {"FileType", "text", "setlocal textwidth=78"},

        -- These should probably be editorconfig settings
        {"FileType", "json", "let g:indentLine_setConceal = 0"},
        {"FileType", "puppet", "setlocal ts=4 sts=4 sw=4 expandtab"},
        {"FileType", "ruby", "setlocal ts=4 sts=4 sw=4 expandtab"},
        {"FileType", "terraform", "setlocal ts=2 sts=2 sw=2 expandtab"},
        {"FileType", "yaml", "setlocal ts=4 sts=4 sw=4 expandtab"},

        -- When editing a file, always jump to the last known cursor position.
        {"BufReadPost", "*", 'silent! normal! g`"zv'},
    }
})

-- Technically autocmds are happening behind this, they're just abstracted away
util.filetype_extensions({
    terraform = {
        "tfbackend",
    },
})

-- Start at line 1 of git commit messages, always.
-- This prevents us from starting at a random location in the file, quite often
-- in the default comments of the COMMIT_EDITMSG file.
api.nvim_create_autocmd({ "BufEnter" }, {
    desc = "Set cursor to first line in git commit messages",
    pattern = "COMMIT_EDITMSG",
    callback = function()
        fn.setpos(".", {0, 1, 1, 0})
    end,
})
