-- Git module
local filesystem = require "filesystem"
local util = require "util"
local flatten = vim.fn.flatten
local system = vim.fn.system

local CLONE = "clone"
local GIT = "git"

-- Clones a git repo from repo to dest
-- Returns false on failure, true on success
local function clone(repository, destination, options)
    if not filesystem.is_executable(GIT) then
        print("git not found, cannot continue")

        return false
    end

    local args = options or {}

    local cmd = {
        GIT,
        CLONE,
        repository,
        args,
        destination,
    }

    system(flatten(cmd))

    return util.is_exit_success()
end

-- Exposed API
return {
    clone = clone,
}
