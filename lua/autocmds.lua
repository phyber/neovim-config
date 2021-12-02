-- autocmds
local util = require "util"

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

        -- Run Neomake after any buffer write.
        {"BufWritePost", "*", "Neomake"},

        -- When editing a file, always jump to the last known cursor position.
        -- Don't do it when the position is invalid or when inside an event hander
        -- (happens when dropping a file on gvim).
        -- Also don't do it when the mark is in the first line, that i the default
        -- position when opening a file
        {
            "BufReadPost",
            "*",
            -- Multiline enclosing here to prevent special treatment of various
            -- characters.
            [[if line("'\"") > 1 && line("'\"") < line("$") | exe "normal! g`\"" | endif]],
        },
    }
})
