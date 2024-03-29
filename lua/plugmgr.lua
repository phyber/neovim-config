-- Plugmgr
-- This file handles the installation and configuration of the plugin manager.
local filesystem = require "filesystem"
local machine = require "machine"

-- Settings
local plugmgr = {
    path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    repo = "https://github.com/folke/lazy.nvim.git",
    options = {
        "--branch=stable",
        "--filter=blob:none",
    },
}

-- Checks if the plugmgr is installed by checking for its install directory
local function plugmgr_installed()
    return filesystem.is_directory(plugmgr.path)
end

-- If the plugmgr isn't installed, create a function that can be used to
-- install it and notify the user to perform a :PackerSync
if not plugmgr_installed() then
    local git = require "git"

    -- This needs to be called via :lua
    function InstallPlugMgr()
        local success = git.clone(plugmgr.repo, plugmgr.path, plugmgr.options)
        if not success then
            return
        end

        print("Restart nvim to complete setup of plugmgr")
    end

    print("Plugin manager not installed, run :lua InstallPlugMgr()")
else
    vim.opt.rtp:prepend(plugmgr.path)

    local config = {
        -- Reloading neovim is fine.
        change_detection = {
            enabled = false,
        },
        git = {},
        install = {
            -- Sets the colorscheme when installs are happening at startup.
            colorscheme = {
                "monokai",
            },
        },
    }

    if machine.is_raspberry_pi() then
        -- RaspberryPi can be slow, allow a longer timeout
        config.git.timeout = 60 * 5
    end

    require("lazy").setup("plugins", config)
end
