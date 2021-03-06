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

    local jit_os = jit.os

    mkdir = function(path, mode, no_parents)
        -- Attempt to use a provided mode, the default from the above table, or
        -- finally, 0700.
        local final_mode = mode or modes[jit_os] or "0700"
        local parents = no_parents and "" or "p"

        fn.mkdir(path, parents, final_mode)
    end
end

-- Return true if a feature is present
local function nvim_has(feature)
    return fn.has(feature) == 1
end

-- Check if a plugin is loaded
local function plugin_loaded(name)
    local plugin = packer_plugins[name]

    return plugin and plugin.loaded
end

-- Key remapping helpers
local function keymap(mode, key, cmd, options)
    if not options then
        options = {}
    end

    api.nvim_set_keymap(mode, key, cmd, options)
end

local function imap(key, cmd, options)
    keymap("i", key, cmd, options)
end

local function inoremap(key, cmd)
    local options = {
        noremap = true,
    }

    imap(key, cmd, options)
end

local function map(key, cmd, options)
    keymap("", key, cmd, options)
end

local function nmap(key, cmd, options)
    keymap("n", key, cmd, options)
end

local function nnoremap(key, cmd)
    local options = {
        noremap = true,
    }

    nmap(key, cmd, options)
end

local function vmap(key, cmd, options)
    keymap("v", key, cmd, options)
end

local function vnoremap(key, cmd, options)
    local options = {
        noremap = true,
    }

    vmap(key, cmd, options)
end

-- Autocmds
local function create_augroups(groups)
    for group, content in pairs(groups) do
        api.nvim_command(("augroup %s"):format(group))
        api.nvim_command("autocmd!")

        for _, command in pairs(content) do
            local line

            if type(command) == "table" then
                -- {"Event", "Pattern", "Command"} style autocommands.
                line = ("autocmd %s %s %s"):format(unpack(command))
            else
                -- "Event Pattern Command" style autocommands.
                line = ("autocmd %s"):format(command)
            end

            api.nvim_command(line)
        end

        api.nvim_command("augroup END")
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
    create_augroups     = create_augroups,
    filetype_extensions = filetype_extensions,
    is_directory        = is_directory,
    is_executable       = is_executable,
    is_exit_success     = is_exit_success,
    is_file             = is_file,
    mkdir               = mkdir,
    nvim_has            = nvim_has,
    plugin_loaded       = plugin_loaded,

    -- Key mapping
    imap     = imap,
    inoremap = inoremap,
    map      = map,
    nmap     = nmap,
    nnoremap = nnoremap,
    vmap     = vmap,
    vnoremap = vnoremap,
}
