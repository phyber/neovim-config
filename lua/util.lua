-- Utils module
-- We wrap a few functions to return proper booleans from them so callers don't
-- have to bother with "== 1", etc.
-- Return true if given path is a directory
local function is_dir(path)
    return vim.fn.isdirectory(path) == 1
end

-- Return true if given binary an be executed
local function is_executable(binary)
    return vim.fn.executable(binary) == 1
end

-- Creates a directory, mode and no_parents are optional.
-- By default will attempt to create parent directories if they don't exist and
-- will create private (0700) directories if a mode isn't given.
--
-- The caller should check for existance of the directories before calling
-- this function.
local function mkdir(path, mode, no_parents)
    -- FreeBSD doesn't seem to accept the octal literal here, possibly due to
    -- the underlying mkdir stuff.
    local modes = {
        -- Operating systems here are listed by the names that `jit.os`
        -- returns.
        BSD = "0700",
        Linux = "0o700",
    }

    -- Attempt to use a provided mode, the default from the above table, or
    -- finally, 0700.
    local final_mode = mode or modes[jit.os] or "0700"
    local parents = no_parents and "" or "p"

    vim.fn.mkdir(path, parents, final_mode)
end

-- Return true if a feature is present
local function nvim_has(feature)
    return vim.fn.has(feature) == 1
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

    vim.api.nvim_set_keymap(mode, key, cmd, options)
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

-- Autocmds
local function create_augroups(groups)
    for group, content in pairs(groups) do
        vim.api.nvim_command("augroup " .. group)
        vim.api.nvim_command("autocmd!")

        for _, command in pairs(content) do
            local line

            if type(command) == "table" then
                -- {"Event", "Pattern", "Command"} style autocommands.
                local event = command[1]
                local pattern = command[2]
                local cmd = command[3]

                line = ("autocmd %s %s %s"):format(event, pattern, cmd)
            else
                -- "Event Pattern Command style autocommands.
                line = ("autocmd %s"):format(command)
            end

            vim.api.nvim_command(line)
        end

        vim.api.nvim_command("augroup END")
    end
end

-- Exposed API
return {
    -- Helpers
    create_augroups = create_augroups,
    is_dir          = is_dir,
    is_executable   = is_executable,
    mkdir           = mkdir,
    nvim_has        = nvim_has,
    plugin_loaded   = plugin_loaded,

    -- Key mapping
    imap     = imap,
    inoremap = inoremap,
    map      = map,
    nmap     = nmap,
    nnoremap = nnoremap,
}
