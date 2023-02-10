local plugin = {
    "glepnir/indent-guides.nvim",
    config = function()
        -- The default colours here hid the cursor when it was over an
        -- indent guide.
        local guide_colours = {
            bg = "#23272e",
            fg = "#d0d0d0",
        }

        require("indent_guides").setup({
            even_colors = guide_colours,
            odd_colors = guide_colours,
        })
    end,
}

return plugin
