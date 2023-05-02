-- Git module
local filesystem = require "filesystem"
local util = require "util"
local system = vim.fn.system

local GIT = "git"
local GIT_CLONE = "git clone %s %s %s"

-- Clones a git repo from repo to dest
-- Returns false on failure, true on success
local function clone(repo, dest, options)
    if not filesystem.is_executable(GIT) then
        print("git not found, cannot continue")

        return false
    end

    local args = table.concat(options or {}, " ")
    system(GIT_CLONE:format(repo, args, dest))

    return util.is_exit_success()
end

-- Exposed API
return {
    clone = clone,
}
