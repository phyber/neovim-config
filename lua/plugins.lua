-- Plugins
local util = require "util"

-- Settings
local plugmgr = {
    path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim",
    repo = "https://github.com/wbthomason/packer.nvim",
}

-- Checks if the plugmgr is installed by checking for its install directory
local function plugmgr_installed()
    return util.is_dir(plugmgr.path)
end

-- If the plugmgr isn't installed, create a function that can be used to
-- install it and notify the user to perform a :PackerSync
if not plugmgr_installed() then
    -- This needs to be called via :lua
    function InstallPlugMgr()
        if not util.is_executable("git") then
            print("git not found, cannot continue")

            return
        end

        local cmd = ("git clone %s %s"):format(plugmgr.repo, plugmgr.path)
        vim.fn.system(cmd)

        print("Restart vim and run :PackerSync")
    end

    print("Plugin manager not installed, run :lua InstallPlugMgr()")
else
    -- Any changes here will require running at least :PackerCompile
    -- New plugins will require a :PackerSync
    local function plugins()
        -- Plugins we're not passing options to
        -- Editor Config (https://editorconfig.org/)
        use "editorconfig/editorconfig-vim"

        -- Help with tabular data
        --use "godlygeek/tabular"

        -- Neomake
        use "neomake/neomake"

        -- Highlight extra whitespace
        use "ntpeters/vim-better-whitespace"

        -- Use Git from vim
        --use "tpope/vim-fugitive"

        -- Plugin manager
        use "wbthomason/packer.nvim"

        -- indent guide
        use "glepnir/indent-guides.nvim"
        --use "Yggdroot/indentLine"


        -- Plugins we pass options too
        -- TOML syntax highlighting
        use {
            "cespare/vim-toml",
            ft = "toml",
        }

        -- Tab line
        use {
            "crispgm/nvim-tabline",
            config = function()
                require("tabline").setup({})
            end,
        }

        -- Fish syntax highlighting
        use {
            "dag/vim-fish",
            ft = "fish",
        }

        -- Go syntax highlighting and more
        use {
            "fatih/vim-go",
            ft = "go",
            setup = function()
                vim.g.go_fmt_autosave = 1
                vim.g.go_fmt_command = "goimports"
            end,
        }

        -- Status bar
        use {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("lualine").setup({
                    options = {
                        icons_enabled = false,
                        theme = "material",

                        -- No fancy separators, not all terminals have the
                        -- rights fonts.
                        component_separators = {
                            left = nil,
                            right = nil,
                        },
                        section_separators = {
                            left = nil,
                            right = nil,
                        },
                    },
                })
            end,
        }

        -- Terraform syntax highlighting
        use {
            "hashivim/vim-terraform",
            ft = "terraform",
        }

        -- Git diff status in the sidebar
        use {
            "lewis6991/gitsigns.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("gitsigns").setup()
            end,
        }

        use {
            "majutsushi/tagbar",
            disable = true,
            cmd = "Tagbar",
            setup = function()
                vim.g.tagbar_type_go = {
                    ctagsargs = "-sort -silent",
                    ctagsbin = "gotags",
                    ctagstype = "go",
                    sro = ".",
                    kind2scope = {
                        t = "ctype",
                        n = "ntype",
                    },
                    kinds = {
                        "p:package",
                        "i:imports:1",
                        "c:constants",
                        "v:variables",
                        "t:types",
                        "n:interfaces",
                        "w:fields",
                        "e:embedded",
                        "m:methods",
                        "r:constructor",
                        "f:functions",
                    },
                    scope2kind = {
                        ctype = "t",
                        ntype = "n",
                    },
                }
            end,
        }

        use {
            "nsf/gocode",
            ft = "go",
            rtp = "vim",
        }

        -- Python syntax checking
        use {
            "nvie/vim-flake8",
            ft = "python",
        }

        -- Fuzzy finder
        use {
            "nvim-telescope/telescope.nvim",
            requires = "nvim-lua/plenary.nvim",
        }

        -- Rust syntax highlighting
        use {
            "rust-lang/rust.vim",
            ft = "rust",
        }

        -- Lua syntax
        use {
            "tbastos/vim-lua",
            ft = "lua",
        }

        -- Puppet syntax
        use {
            "voxpupuli/vim-puppet",
            ft = "puppet",
        }

        use {
            "Blackrush/vim-gocode",
            ft = "go",
        }

        -- Python indenting
        use {
            "Vimjas/vim-python-pep8-indent",
            ft = "python",
        }

        -- Theme
        use {
            -- Enabled but not used, mostly for comparison at the moment when
            -- monokai doesn't quite match what we want.
            "fatih/molokai",
            config = function()
                --vim.cmd([[
                --    colorscheme molokai
                --]])
            end,
            setup = function()
                vim.g.rehash256 = 1
            end,
        }

        use {
            "tanvirtin/monokai.nvim",
            config = function()
                -- We mostly turn the theme into molokai here.
                -- We should probably just create a real molokai theme at some
                -- point.
                local monokai = require("monokai")
                local palette = monokai.classic

                -- Colours that are close to molokai
                local molokai = {
                    grey = "#1c1c1c",
                    special_comment = "#8a8a8a",
                    white = "#d0d0d0",
                }

                monokai.setup({
                    custom_hlgroups = {
                        Normal = {
                            fg = molokai.white,
                            bg = molokai.grey,
                        },
                        CursorLineNr = {
                            fg = palette.orange,
                            bg = molokai.grey,
                        },
                        Delimiter = {
                            fg = palette.grey,
                        },
                        Identifier = {
                            fg = palette.orange,
                        },
                        Include = {
                            fg = palette.green,
                        },
                        LineNr = {
                            fg = palette.base5,
                            bg = molokai.grey,
                        },
                        SignColumn = {
                            fg = palette.white,
                            bg = molokai.grey,
                        },
                        SpecialComment = {
                            fg = molokai.special_comment,
                            style = "bold",
                        },
                        StatusLine = {
                            fg = palette.base7,
                            bg = molokai.grey,
                        },
                    },
                })

                vim.cmd("colorscheme monokai")
            end,
        }
    end

    require("packer").startup({
        plugins,
        config = {
            auto_clean = false,
            display = {
                open_fn = require("packer.util").float,
            },
        },
    })
end
