-- Key bindings
local util = require "util"

util.inoremap("<C-U>", "<C-G>u<C-U>")
util.map("Q", "gq")
util.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")
util.nnoremap("<C-Left>", ":bprevious<CR>")
util.nnoremap("<C-Right>", ":bnext<CR>")
