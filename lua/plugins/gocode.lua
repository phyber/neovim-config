local plugin = {
    "nsf/gocode",
    enabled = false,
    ft = "go",
    config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "vim")
    end,
}

return plugin
