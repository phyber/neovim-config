-- Utils module
local fn = vim.fn
local loop = vim.loop

-- Check if a given path exists.
local function path_exists(path)
    return loop.fs_stat(path) ~= nil
end

-- We wrap a few functions to return proper booleans from them so callers don't
-- have to bother with "== 1", etc.
-- Return true if given path is a directory
local function is_directory(path)
    return fn.isdirectory(path) == 1
end

-- Return true if given binary an be executed
local function is_executable(binary)
    return fn.executable(binary) == 1
end

-- Return true if a given path is a file.
-- We can't just check for "not is_directory" as that would also be true when
-- a path doesn't exist, we have to specifically test for a path existing.
local function is_file(path)
    return path_exists(path) and not is_directory(path)
end

-- Creates a directory, mode and no_parents are optional.
-- By default will attempt to create parent directories if they don't exist and
-- will create private (0700) directories if a mode isn't given.
--
-- The caller should check for existance of the directories before calling
-- this function.
local mkdir
do
    -- FreeBSD doesn't seem to accept the octal literal here, possibly due to
    -- the underlying mkdir stuff.
    local modes = {
        -- Operating systems here are listed by the names that `jit.os`
        -- returns.
        BSD = "0700",
        Linux = "0o700",
    }

    -- On aarch64 (at least in the snapcraft package) we currently don't have
    -- LuaJIT. Workaround that.
    local osname

    if jit then
        osname = jit.os
    else
        local uname = loop.os_uname().sysname

        -- LuaJIT returns BSD, while uname returns the real kernel name, like
        -- FreeBSD. Fix up those cases.
        if uname:find("BSD") then
            osname = "BSD"
        else
            osname = uname
        end
    end

    mkdir = function(path, mode, no_parents)
        -- Attempt to use a provided mode, the default from the above table, or
        -- finally, 0700.
        local final_mode = mode or modes[osname] or "0700"
        local parents = no_parents and "" or "p"

        fn.mkdir(path, parents, final_mode)
    end
end

-- Exposed API
return {
    -- Filesystem
    is_directory  = is_directory,
    is_executable = is_executable,
    is_file       = is_file,
    mkdir         = mkdir,
}
