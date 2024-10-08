-- Highlights
local api = vim.api
local GLOBAL_HIGHLIGHT_GROUP = 0

-- Quick wrapper because everything we're doing is global.
local function highlight(group, val)
    api.nvim_set_hl(GLOBAL_HIGHLIGHT_GROUP, group, val)
end

-- Called when our event is fired.
-- We could probably move these to the theme configuration in the future.
local function set_highlights()
    -- Colour the selection menus
    -- Each of these previously had `gui=bold`, but that's not an option in
    -- nvim_set_hl, simply `bold = bool`. Omit it for now.
    highlight("Pmenu", {
        ctermbg = "darkblue",
        ctermfg = "white",
    })

    highlight("PmenuSel", {
        ctermbg = "grey",
        ctermfg = "black",
    })

    -- CursorLine is slow over SSH, disable it if we're connected that way.
    if os.getenv("SSH_CONNECTION") then
        -- Don't highlight the whole line, only the line number.
        -- This clears the CursorLine highlight.
        highlight("CursorLine", {})
    end
end

-- We can call this manually if needed
api.nvim_create_user_command("SetHighlights", set_highlights, {
    desc = "Set Highlights",
    force = true,
})

-- We're more likely to be called via this event
api.nvim_create_autocmd("User", {
    callback = set_highlights,
    pattern = "ColorSchemeLoaded",
})
