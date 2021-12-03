-- Key bindings
local util = require "util"

util.inoremap("<C-U>", "<C-G>u<C-U>")
util.map("Q", "gq")

-- Toggle line numbers
util.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")

-- Previous buffer
util.nnoremap("<C-Left>", ":bprevious<CR>")

-- Next buffer
util.nnoremap("<C-Right>", ":bnext<CR>")

-- Closes the buffer
util.nnoremap("<Leader><BS>", ":bdelete<CR>")

-- Telescope fuzzy finder
util.nnoremap("<Leader>fb", ":Telescope buffers<CR>")
util.nnoremap("<Leader>ff", ":Telescope find_files<CR>")
util.nnoremap("<Leader>fg", ":Telescope live_grep<CR>")
util.nnoremap("<Leader>fh", ":Telescope help_tags<CR>")

-- This function and keybind help with learning what syntax highlighting is
-- being applied to an element under the cursor.
vim.cmd([[
function! SynStack()
    if !exists("*synstack")
        return
    endif

    echo map(synstack(line("."), col(".")), 'synIDattr(v:val, "name")')
endfunction
]])

util.nmap("<Leader>z", ":call SynStack()<CR>")
