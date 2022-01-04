-- Highlights
local util = require "util"

-- Once vim.ap.nvim_set_hl supports namespace 0 (global highlight) we should be
-- able to replace this with Lua.
vim.cmd([[
function! SetHighlights() abort
    " Colour the selection menus
    highlight Pmenu ctermbg=darkblue ctermfg=white gui=bold
    highlight PmenuSel ctermbg=grey ctermfg=black gui=bold

    " Don't highlight the whole line, only the line number
    highlight clear CursorLine
endfunction
]])

util.create_augroups({
    Highlights = {
        {"ColorScheme", "*", "call SetHighlights()"},
    }
})
