-- Utils module
local api = vim.api
local fn = vim.fn

-- Returns true if the given item is empty.
-- See ":help empty" for what consitutes empty.
local function empty(item)
    return fn.empty(item) == 1
end

-- the Vim API has no direct way to check that a path exists, so we work around
-- that by checking for an empty glob.
local function path_exists(path)
    return not empty(fn.glob(path))
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

-- Return true if the previous system command was successful (exit code 0)
local function is_exit_success()
    -- shell_error will be set to the exit code of the system command
    return api.nvim_get_vvar("shell_error") == 0
end

local os_uname
do
    local uname = ""

    local f = io.popen("uname -s")
    if f then
        uname = f:read("*a")
        f:close()
    end

    os_uname = function()
        return uname
    end
end

-- Return true if the system is FreeBSD
local is_freebsd
do
    local freebsd = os_uname():find("FreeBSD") ~= nil

    is_freebsd = function()
        return freebsd
    end
end

-- Return true if the system appears to be a Raspberry Pi
-- Works on a Raspberry Pi 4.
local is_raspberry_pi
do
    local pi = false

    local f = io.open("/proc/cpuinfo")
    if f then
        for line in f:lines() do
            if line:find("Model", 1, true) then
                pi = line:find("Raspberry Pi") ~= nil
                break
            end
        end

        f:close()
    end

    is_raspberry_pi = function()
        return pi
    end
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
        local uname = os_uname()

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

-- Return true if a feature is present
local function nvim_has(feature)
    return fn.has(feature) == 1
end

-- Key remapping helpers
local function keymap(mode, key, command, options)
    api.nvim_set_keymap(mode, key, command, options or {})
end

local function imap(key, command, opts)
    keymap("i", key, command, opts)
end

local function inoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    imap(key, command, options)
end

local function map(key, command, options)
    keymap("", key, command, options)
end

local function nmap(key, command, options)
    keymap("n", key, command, options)
end

local function nnoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    nmap(key, command, options)
end

local function vmap(key, command, options)
    keymap("v", key, command, options)
end

local function vnoremap(key, command, options)
    local noremap = {
        noremap = true,
    }

    options = vim.tbl_deep_extend("keep", noremap, options or {})

    vmap(key, command, options)
end

-- Autocmds
local function create_augroups(groups)
    for group, content in pairs(groups) do
        -- Create a named autogroup
        api.nvim_create_augroup(group, {
            clear = true,
        })

        -- Add the events to the created group
        for _, input in pairs(content) do
            local event = input[1]
            local pattern = input[2]
            local command = input[3]

            api.nvim_create_autocmd({ event }, {
                group = group,
                pattern = { pattern },
                command = command,
            })
        end
    end
end

-- Set filetypes for specific file extensions, abstracts augroups for this
-- specific use case.
local function filetype_extensions(types)
    local EXTENSION_FORMAT = "*.%s"
    local FILETYPE_FORMAT = "set filetype=%s"
    local GROUP_NAME_FORMAT = "manualfiletype_%s"

    local groups = {}

    for filetype, extensions in pairs(types) do
        for _, extension in pairs(extensions) do
            local group_name = GROUP_NAME_FORMAT:format(filetype)

            groups[group_name] = {
                {
                    "BufRead,BufNewFile",
                    EXTENSION_FORMAT:format(extension),
                    FILETYPE_FORMAT:format(filetype),
                }
            }
        end
    end

    create_augroups(groups)
end

-- Debugging assistance
local function inspect(...)
    print(vim.inspect(...))
end

-- Exposed API
return {
    -- Debugging
    inspect = inspect,

    -- Helpers
    -- Autocmds
    create_augroups     = create_augroups,
    filetype_extensions = filetype_extensions,

    -- Filesystem
    is_directory  = is_directory,
    is_executable = is_executable,
    is_file       = is_file,
    mkdir         = mkdir,

    -- Processes
    is_exit_success = is_exit_success,

    -- Neovim
    is_freebsd      = is_freebsd,
    is_raspberry_pi = is_raspberry_pi,
    nvim_has        = nvim_has,

    -- Key mapping
    imap     = imap,
    inoremap = inoremap,
    map      = map,
    nmap     = nmap,
    nnoremap = nnoremap,
    vmap     = vmap,
    vnoremap = vnoremap,
}
