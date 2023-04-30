-- Plugmgr
-- This file handles the installation and configuration of the plugin manager.
local machine = require "machine"
local util = require "util"

-- Settings
local plugmgr = {
    path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    repo = "https://github.com/folke/lazy.nvim.git",
    opts = {
        "--branch=stable",
        "--filter=blob:none",
    },
}

-- Checks if the plugmgr is installed by checking for its install directory
local function plugmgr_installed()
    return util.is_directory(plugmgr.path)
end

-- If the plugmgr isn't installed, create a function that can be used to
-- install it and notify the user to perform a :PackerSync
if not plugmgr_installed() then
    local git = require "git"

    -- This needs to be called via :lua
    function InstallPlugMgr()
        local success = git:clone(plugmgr.repo, plugmgr.path, plugmgr.opts)
        if not success then
            return
        end

        print("Restart nvim to complete setup of plugmgr")
    end

    print("Plugin manager not installed, run :lua InstallPlugMgr()")
else
    vim.opt.rtp:prepend(plugmgr.path)

    local config = {}

    if machine.is_raspberry_pi() then
        -- RaspberryPi can be slow, allow a longer timeout
        config.git = {}
        config.git.timeout = 60 * 5
    end

    require("lazy").setup("plugins", config)
end
