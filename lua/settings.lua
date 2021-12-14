-- nvim configuration
local util = require "util"
local vim = vim
local fn = vim.fn

-- Allow backspacing over everything in insert mode
vim.o.backspace = "indent,eol,start"

-- Keep a backup file (restore to previous version)
vim.o.backup = true

-- Align switch/case statements
vim.o.cinoptions = ":0"

-- Draw a column at 80 characters
vim.o.colorcolumn = "80"

-- Highlight the cursorline. We only use line number highlighting and disable
-- highlighting of the entire row in highlights.lua.
vim.o.cursorline = true

-- Expand tabs
vim.o.expandtab = true

-- Don't change cursor shape in the different modes. This is mostly for
-- consistency as tmux has difficulties with this and I don't yet want to
-- bother fixing it.
vim.o.guicursor = ""

-- Buffers open in hidden windows
vim.o.hidden = true

-- Command line history size
vim.o.history = 50

-- Incremental searching
vim.o.incsearch = true

-- Line numbers
vim.o.number = true

-- Show the cursor position all the time
vim.o.ruler = true

-- Number of lines of context above/below the cursor
vim.o.scrolloff = 3

-- Shiftwidth, the number of spaces to use for each step of indent
vim.o.shiftwidth = 4

-- Marker for wrapped lines
vim.o.showbreak = "↪ "

-- Display incomplete commands
vim.o.showcmd = true

-- Soft tabstop width, the number of spaces that a tab counts for
vim.o.softtabstop = 4

-- Tabstop width, number of spaces that a tab in the file counts for
vim.o.tabstop = 4

-- Enable true colour
vim.o.termguicolors = true

-- Keep an undo file (undo changes after closing)
vim.o.undofile = true

-- This handles setting of the tmp, backup, and undo directories and creation
-- of them if they don't exist yet.
do
    local basepath_fmt = fn.stdpath("config") .. "/scratch/%s"

    local tmpdirs = {
        backupdir = basepath_fmt:format("backup"),
        directory = basepath_fmt:format("tmp"),
        undodir = basepath_fmt:format("undo"),
    }

    for dirtype, path in pairs(tmpdirs) do
        if not util.is_directory(path) then
            util.mkdir(path)
        end

        -- The actual setting
        vim.o[dirtype] = path .. "//,."
    end
end

-- Add global inspect function
_G.inspect = util.inspect
