-- Key bindings
-- Plugin specific keybinds are configured with that plugin in plugins.lua
local keymap = require "keymap"

keymap.inoremap("<C-U>", "<C-G>u<C-U>")
keymap.map("Q", "gq")

-- Toggle line numbers
keymap.nmap("<F11>", ":set invnumber<CR> :set list!<CR>")
keymap.nmap("<Leader>=", ":set invnumber<CR> :set list!<CR>")

-- Previous buffer
keymap.nnoremap("<C-Left>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Next buffer
keymap.nnoremap("<C-Right>", ":bnext<CR>", { desc = "Next buffer" })

-- Closes the buffer
keymap.nnoremap("<Leader><BS>", ":bdelete<CR>", { desc = "Delete buffer" })

-- Disable macro recording, I never use it but frequently trigger it
-- accidentally
keymap.nmap("q", "<Nop>", { desc = "Macro recording disabled" })

-- iPad Magic Keyboard bindings
-- The § key is in a place that would be useful for Esc
keymap.inoremap("§", "<Esc>", { desc = "Esc for iPad" })
keymap.nnoremap("§", "<Esc>", { desc = "Esc for iPad" })
keymap.vnoremap("§", "<Esc>", { desc = "Esc for iPad" })

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

keymap.nmap("<Leader>z", ":call SynStack()<CR>", { desc = "Show syntax stack" })
