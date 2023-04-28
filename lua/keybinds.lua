-- Key bindings
-- Plugin specific keybinds are configured with that plugin in plugins.lua
local util = require "util"

util.inoremap("<C-U>", "<C-G>u<C-U>")
util.map("Q", "gq")

-- Toggle line numbers
util.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")

-- Previous buffer
util.nnoremap("<C-Left>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Next buffer
util.nnoremap("<C-Right>", ":bnext<CR>", { desc = "Next buffer" })

-- Closes the buffer
util.nnoremap("<Leader><BS>", ":bdelete<CR>", { desc = "Delete buffer" })

-- Disable macro recording, I never use it but frequently trigger it
-- accidentally
util.nmap("q", "<Nop>", { desc = "Macro recording disabled" })

-- iPad Magic Keyboard bindings
-- The § key is in a place that would be useful for Esc
util.inoremap("§", "<Esc>", { desc = "Esc for iPad" })
util.nnoremap("§", "<Esc>", { desc = "Esc for iPad" })
util.vnoremap("§", "<Esc>", { desc = "Esc for iPad" })

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

util.nmap("<Leader>z", ":call SynStack()<CR>", { desc = "Show syntax stack" })
