-- Highlights
vim.cmd([[
function! SetHighlights() abort
    " Colour the selection menus
    highlight Pmenu ctermbg=darkblue ctermfg=white gui=bold
    highlight PmenuSel ctermbg=grey ctermfg=black gui=bold

    " Don't highlight the whole line, only the line number
    highlight clear CursorLine
endfunction

augroup Highlights
    autocmd!
    autocmd ColorScheme * call SetHighlights()
augroup END
]])
