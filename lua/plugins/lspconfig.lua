return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim",

            -- nvim-ufo
            "kevinhwang91/nvim-ufo",
            "kevinhwang91/promise-async",

            -- File operations
            "antosha417/nvim-lsp-file-operations"
        },
        lazy = false,
        config = function()
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("blink.cmp").get_lsp_capabilities(),
                require("lsp-file-operations").default_capabilities(),
                {
                    textDocument = {
                        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
                        completion = {
                            completionItem = { snippetSupport = true }
                        },
                    },
                }
            )
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Folding

            vim.opt.foldcolumn = "0"
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true

            -- LSP

            local lsps = {
                "angularls",
                "bashls",
                "clangd",
                "cssls",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "eslint",
                "html",
                "jdtls",
                "ltex",
                "lua_ls",
                "protols",
                "texlab",
                "ts_ls",
                "vimls",
            };

            for _, lsp in ipairs(lsps) do
                vim.lsp.enable(lsp)
            end

            vim.lsp.config("ltex", {
                cmd_env = { JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0" },
            })

            vim.lsp.config("eslint", {
                root_markers = { ".eslintrc.json" },
                settings = {
                    -- useFlatConfig = false,
                },
            })

            vim.lsp.config("sqlls", {
                filetypes = { "sql" },
                root_dir = function(_)
                    return vim.loop.cwd()
                end,
            })
            vim.lsp.enable("sqlls")

            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = true,
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("pylsp")

            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")

            vim.lsp.config("bicep", {
                cmd = { vim.fn.expand("$MASON/packages/bicep-lsp/bicep-lsp.cmd") },
            })
            vim.lsp.enable("bicep")

            require("ufo").setup()
        end,
        keys = {
            -- LSP keys

            { "gd",    require("custom-functions").go_to_definition, desc = "Go To Definition" },
            { "gi",    vim.lsp.buf.implementation,                   desc = "Go To Implementation" },
            { "gD",    vim.lsp.buf.declaration,                      desc = "Go To Declaration" },
            { "<C-h>", require("custom-functions").hover,            desc = "Mouse Hover" },
            {
                "<F2>",
                function()
                    vim.lsp.buf.rename()
                end,
                desc = "Rename"
            },

            -- Folds keys

            { "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
            { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
        }
    },
}
