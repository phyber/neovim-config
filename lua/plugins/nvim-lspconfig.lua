-- Language Server Protocol config
local plugin = {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- Table of servers and their config, if any.
        local servers = {
            rust_analyzer = {
                cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            },
            terraformls = {},
        }

        local client_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(
            client_capabilities
        )

        -- General configuration that will be merged with server
        -- specific configs.
        local general_config = {
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        }

        for lsp, config in pairs(servers) do
            local merged_config = vim.tbl_deep_extend(
            "keep",
            config,
            general_config
            )

            lspconfig[lsp].setup(merged_config)
        end
    end,
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
}

return plugin
