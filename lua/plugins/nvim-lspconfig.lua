-- Language Server Protocol config
local plugin = {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local machine = require("machine")
        local vim = vim

        -- Table of servers and their config, if any.
        local servers = {
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
            ruff_lsp = {},
            rust_analyzer = {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
            },
            terraformls = {
                -- terraform-ls sends a lot of output to stderr, not just
                -- errors. Send all of its junk to /dev/null. They're fixing
                -- this upstream in #1271.
                cmd = { "terraform-ls", "serve", "-log-file=/dev/null" },
            },
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
    end,
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
}

return plugin
