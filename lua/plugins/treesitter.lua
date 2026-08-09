return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)

            local ensureInstalled = {
                "angular",
                "asm",
                "bash",
                "bibtex",
                "bicep",
                "c",
                "c_sharp",
                "cmake",
                "comment",
                "cpp",
                "css",
                "csv",
                "dart",
                "desktop",
                "diff",
                "dockerfile",
                "dot",
                "dtd",
                "editorconfig",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "html",
                "http",
                "java",
                "javadoc",
                "javascript",
                "jq",
                "jsdoc",
                "json",
                "json5",
                "kotlin",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "meson",
                "nginx",
                "ninja",
                "nix",
                "passwd",
                "php",
                "powershell",
                "printf",
                "pymanifest",
                "python",
                "regex",
                "rust",
                "scss",
                "sql",
                "svelte",
                "tmux",
                "toml",
                "tsv",
                "tsx",
                "typescript",
                "typespec",
                "typoscript",
                "udev",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml",
                "zig",
            }

            local alreadyInstalled = require("nvim-treesitter.config").get_installed()
            local parsersToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parsersToInstall)

            require("nvim-treesitter").install()

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        -- Used by surround plugin
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = "nvim-treesitter/nvim-treesitter",
    }
}
