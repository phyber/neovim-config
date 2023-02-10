-- Molokai theme
local plugin = {
    -- Enabled but not used, mostly for comparison at the moment when
    -- monokai doesn't quite match what we want.
    "fatih/molokai",
    config = function()
        --vim.cmd([[
        --    colorscheme molokai
        --]])
    end,
    setup = function()
        vim.g.rehash256 = 1
    end,
}

return plugin
