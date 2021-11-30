-- autocmds
-- We can't do this in Lua yet, we probably want to create some Lua commands
-- ourselves to deal with it
vim.cmd([[
" Enable file type detection
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an auto group so we can delete them easily
augroup vimrcEx
    autocmd!

    set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

    " For all text files set width to 78 characters
    autocmd FileType text setlocal textwidth=78

    " These should probably be editorconfig settings
    autocmd FileType json let g:indentLine_setConceal = 0
    autocmd FileType puppet setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType ruby setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType terraform setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

    " Neomake
    autocmd! BufWritePost * Neomake

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event hander
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that i the default
    " position when opening a file
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") < line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
]])
