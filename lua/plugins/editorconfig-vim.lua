-- Editorconfig (https://editorconfig.org)
local plugin = {
    "editorconfig/editorconfig-vim",
    cond = function()
        -- Neovim 0.9+ include editorconfig functionality by default
        return not require("util").nvim_has("nvim-0.9")
    end,
}

return plugin
