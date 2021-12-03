-- Key bindings
local util = require "util"

util.inoremap("<C-U>", "<C-G>u<C-U>")
util.map("Q", "gq")

-- Ctrl-Backspace closes the buffer
-- When viewing on GitHub this looks empty, but there is a ^H here.
util.nmap("", ":bdelete<CR>")

-- Toggle line numbers
util.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")

-- Previous buffer
util.nnoremap("<C-Left>", ":bprevious<CR>")

-- Next buffer
util.nnoremap("<C-Right>", ":bnext<CR>")

-- Telescope fuzzy finder
util.nnoremap("<Leader>fb", ":Telescope buffers<CR>")
util.nnoremap("<Leader>ff", ":Telescope find_files<CR>")
util.nnoremap("<Leader>fg", ":Telescope live_grep<CR>")
util.nnoremap("<Leader>fh", ":Telescope help_tags<CR>")
