-- Key remapping helpers
local api = vim.api

local function imap(key, command, options)
    api.nvim_set_keymap("i", key, command, options or {})
end

local function inoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    imap(key, command, options)
end

local function map(key, command, options)
    api.nvim_set_keymap("", key, command, options or {})
end

local function nmap(key, command, options)
    api.nvim_set_keymap("n", key, command, options or {})
end

local function nnoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    nmap(key, command, options)
end

local function vmap(key, command, options)
    api.nvim_set_keymap("v", key, command, options or {})
end

local function vnoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    vmap(key, command, options)
end

-- Exposed API
return {
    imap     = imap,
    inoremap = inoremap,
    map      = map,
    nmap     = nmap,
    nnoremap = nnoremap,
    vmap     = vmap,
    vnoremap = vnoremap,
}
