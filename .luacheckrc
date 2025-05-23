-- vim:ft=lua:
stds.nvim = {
    globals = {
        "vim",
    },
    read_globals = {
        "jit",
    },
}

stds.config = {
    globals = {
        "InstallPlugMgr",
    },
    read_globals = {
        "packer_plugins",
        "use",
    },
}

std = "lua51+nvim+config"

exclude_files = {
    "plugin/packer_compiled.lua",
    "scratch/*",
}

ignore = {
    -- Ignore variables prefixed with an _
    "21/_.*",
}
