local plugin = {
    "nsf/gocode",
    ft = "go",
    config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "vim")
    end,
}

return plugin
