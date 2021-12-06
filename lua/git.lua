-- Git module
local fn = vim.fn
local util = require "util"

local git = {}

git.cmds = {
    base = "git",
    clone = "git clone %s %s",
}

-- Clones a git repo from repo to dest
-- Returns false on failure, true on success
function git:clone(repo, dest)
    if not util.is_executable(self.cmds.base) then
        print("git not found, cannot continue")

        return false
    end

    fn.system(self.cmds.clone:format(repo, dest))

    return util.was_shell_success()
end

-- Exposed API
return git
