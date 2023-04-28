-- Language Server Protocol config
local plugin = {
    "neovim/nvim-lspconfig",
    config = function()
        local util = require "util"

        -- We index this in a loop, so get a local.
        local vim = vim

        -- Disable LSP server logging, terraform-ls is far too broken and lots
        -- of errors end up being logged.
        -- We might be able to disable this per server, but for now just
        -- disable globally.
        vim.lsp.set_log_level("OFF")

        local lspconfig = require("lspconfig")

        -- Table of servers and their config, if any.
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                            },
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
            terraformls = {},
        }

        -- Don't enable rust-analyzer on a Raspberry Pi
        if not util.is_raspberry_pi() then
            servers.rust_analyzer = {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
            }
        end

        local client_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(
            client_capabilities
        )

        -- Global configuration that will be merged with server specific
        -- configs.
        local global_config = {
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            on_attach = function(client, _bufnr)
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
