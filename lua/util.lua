-- Utils module
local api = vim.api
local fn = vim.fn

-- Return true if the previous system command was successful (exit code 0)
local function is_exit_success()
    -- shell_error will be set to the exit code of the system command
    return api.nvim_get_vvar("shell_error") == 0
end

-- Return true if a feature is present
local function nvim_has(feature)
    return fn.has(feature) == 1
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
            local events = input[1]
            local pattern = input[2]
            local command = input[3]

            api.nvim_create_autocmd(events, {
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
                    { "BufRead", "BufNewFile" },
                    EXTENSION_FORMAT:format(extension),
                    FILETYPE_FORMAT:format(filetype),
                }
            }
        end
    end

    create_augroups(groups)
end

-- Debugging assistance
-- No longer injected into _G since we can ":lua =foo" to get a reasonable
-- inspect output.
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

    -- Processes
    is_exit_success = is_exit_success,

    -- Neovim
    nvim_has = nvim_has,
}
