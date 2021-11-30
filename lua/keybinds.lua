-- Key bindings
local util = require "util"

util.inoremap("<C-U>", "<C-G>u<C-U>")
util.map("Q", "gq")

-- Ctrl-Backspace closes the buffer
util.nmap("", ":bdelete<CR>")

-- Toggle line numbers
util.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")

-- Previous buffer
util.nnoremap("<C-Left>", ":bprevious<CR>")

-- Next buffer
util.nnoremap("<C-Right>", ":bnext<CR>")
