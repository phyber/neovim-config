-- Language Server Protocol config
local plugin = {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local machine = require("machine")
        local vim = vim

        -- Table of servers and their config, if any.
        local servers = {
            gopls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "jit",
                                "vim",
                            },
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        telemetry = {
                            enable = false,
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            },
            puppet = {
                cmd = { "puppet-languageserver", "--stdio", "--debug=STDOUT" },
                filetypes = { "puppet" },
            },
            ruff_lsp = {},
            rust_analyzer = {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
            },
            -- TerraformLS currently doesn't exit properly when nvim does, and
            -- leaves behind many copies of itself burning CPU. Disable for
            -- now.
            --terraformls = {
            --    -- terraform-ls sends a lot of output to stderr, not just
            --    -- errors. Send all of its junk to /dev/null. They're fixing
            --    -- this upstream in #1271.
            --    cmd = { "terraform-ls", "serve", "-log-file=/dev/null" },
            --},
        }

        if machine.is_freebsd() then
            -- lua-language-server doesn't exist for FreeBSD. Don't try to
            -- enable it there.
            servers.lua_ls = nil
        end

        if machine.is_raspberry_pi() then
            -- Don't enable rust-analyzer on a Raspberry Pi.
            servers.rust_analyzer = nil
        end

        -- Global configuration that will be merged with server specific
        -- configs.
        local global_config = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            ),
            flags = {
                debounce_text_changes = 150,
            },
            on_attach = function(client, _bufnr)
                -- Tokens from the LSP were overriding syntax highlighting in
                -- Rust. Disable tokens from the server.
                client.server_capabilities.semanticTokensProvider = nil
            end,
        }

        -- For each server config, merge it with the global config and call
        -- setup with it.
        for lsp, server_config in pairs(servers) do
            local config = vim.tbl_deep_extend(
                "keep",
                server_config,
                global_config
            )

            lspconfig[lsp].setup(config)
        end

        -- Create a keybinding for getting function definitions from the LSP
        local group = vim.api.nvim_create_augroup("UserLspConfig", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = group,
            callback = function(ev)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                    buffer = ev.buf,
                })
            end,
        })
    end,
    dependencies = {
        "hrsh7th/nvim-cmp",
        "williamboman/mason-lspconfig.nvim",
    },
}

return plugin
