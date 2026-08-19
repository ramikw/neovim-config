-- C# tooling

return {
    {
        "DestopLine/boilersharp.nvim",
        ---@type boilersharp.Config
        opts = {
            namespace = {
                use_file_scoped = "always",
            },
        },
    },
    {
        "seblyng/roslyn.nvim",
        ---@module "roslyn.config"
        ---@type RoslynNvimConfig
        opts = {
            extensions = {
                razor = {
                    enabled = false,
                }
            }
        },
    }
}
