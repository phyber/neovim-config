-- This shows LSP diagnostics on the cmdline like vim did.
local vim = vim
local api = vim.api
local fn = vim.fn
local lsp = vim.lsp

-- nvim function locals
local defer_fn = vim.defer_fn
local get_line_diagnostics = lsp.diagnostic.get_line_diagnostics
local split = vim.split
local nvim_echo = api.nvim_echo
local nvim_get_option = api.nvim_get_option
local nvim_win_get_buf = api.nvim_win_get_buf

-- Constants
local DIAGNOSTIC_SEVERITY_ERROR = lsp.protocol.DiagnosticSeverity.Error
local ECHO_TIMEOUT_MS = 250
local EMPTY_TABLE = {}
local FMT_CHUNK_KIND = "%s: "
local FMT_MESSAGE_LINES = "%s %s"
local FMT_MESSAGE_TRUNCATED = "%s..."
local HLGROUP_ERROR = "ErrorMsg"
local HLGROUP_WARNING = "WarningMsg"
local KIND_ERROR = "error"
local KIND_WARNING = "warning"
local SHORT_LINE_LIMIT = 20

local DIAGNOSTIC_SEVERITY_LIMIT_WARNING = {
    severity_limit = "Warning",
}

local line_diagnostics = {
    bufnr = -1,
    echoed = false,
    line = -1,
    message = EMPTY_TABLE,
}

local function fmt_message(message, severity)
    local kind = KIND_WARNING
    local hlgroup = HLGROUP_WARNING

    -- If we got an error rather than a warning, highlight it differently
    if severity == DIAGNOSTIC_SEVERITY_ERROR then
        kind = KIND_ERROR
        hlgroup = HLGROUP_ERROR
    end

    -- The message we'd like to display
    local chunks = {
        { FMT_CHUNK_KIND:format(kind), hlgroup },
        { message },
    }

    return chunks
end

function line_diagnostics:echo()
    nvim_echo(self.message, false, EMPTY_TABLE)
end

-- Returns nil if there's nothing to do, or true if there's an echo to perform
function line_diagnostics:get()
    local bufnr = nvim_win_get_buf(0)
    local line = fn.line(".") - 1

    -- Don't do anything if we're already echoing the current line for this
    -- buffer.
    if self:is_current(bufnr, line) then
        return
    end

    -- Get the diagnostics of at least a warning for the current line and
    -- buffer.
    local diagnostics = get_line_diagnostics(
        bufnr,
        line,
        DIAGNOSTIC_SEVERITY_LIMIT_WARNING
    )

    -- If there are no diagnostics for the current line
    if #diagnostics == 0 then
        -- If we previously echo'd a message, clear it out by echoing an empty
        -- message.
        if self.echoed then
            self:reset()

            return true
        end

        return
    end

    -- We've got something to echo if we came this far.
    self:set_current(bufnr, line)

    -- Get the first line of the first diagnostic
    local diagnostic = diagnostics[1]
    local lines = split(diagnostic.message, "\n")
    local message = lines[1]

    -- If there are multiple lines and line 1 was short, append line 2
    if #lines > 1 and #message <= SHORT_LINE_LIMIT then
        message = FMT_MESSAGE_LINES:format(message, lines[2])
    end

    local width = nvim_get_option("columns") - 15

    -- If the message is longer than the width we want, truncate it
    if width > 0 and #message >= width then
        message = FMT_MESSAGE_TRUNCATED:format(message:sub(1, width))
    end

    self.message = fmt_message(message, diagnostic.severity)
    return true
end

-- Returns true if the current line is the one being echoed
function line_diagnostics:is_current(bufnr, line)
    return self.echoed and self.bufnr == bufnr and self.line == line
end

-- Reset the last_echo to default values
function line_diagnostics:reset()
    self.bufnr = -1
    self.echoed = false
    self.line = -1
    self.message = EMPTY_TABLE
end

-- Set all last_echo values
function line_diagnostics:set_current(bufnr, line)
    self.bufnr = bufnr
    self.echoed = true
    self.line = line
end

do
    local echo_timer = nil

    local function echo_diagnostic()
        -- If we've been called with a timer already running, stop the existing
        -- timer before starting a new one.
        if echo_timer then
            echo_timer:stop()
        end

        --echo_timer = defer_fn(get_diagnostic, ECHO_TIMEOUT_MS)

        echo_timer = defer_fn(function()
            if line_diagnostics:get() then
                line_diagnostics:echo()
            end
        end, ECHO_TIMEOUT_MS)
    end

    -- Make our echo_diagnostic function global
    _G.echo_diagnostic = echo_diagnostic
end

-- Random line to use when editing this script
local foo = nil

-- Disable virtual text for diagnostics since we're displaying them on the
-- cmdline now.
vim.diagnostic.config({
    virtual_text = false,
})

-- Whenever the cursor moves, call echo_diagnostics
api.nvim_create_autocmd({ "CursorMoved" }, {
    command = ":lua echo_diagnostic()",
    pattern = "*",
})
