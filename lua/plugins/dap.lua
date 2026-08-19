return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
        "mason-org/mason.nvim",
    },
    config = function()
        local dap = require("dap")
        local custom_function = require("custom-functions")

        -- C#
        local coreclr_adapter = {
            type = "executable",
            command = custom_function.is_nixos() and "netcoredbg"
                or custom_function.is_windows() and vim.fn.expand("$MASON/packages/netcoredbg/netcoredbg/netcoredbg.exe")
                or vim.fn.expand("$MASON/packages/netcoredbg/netcoredbg"),
            args = { "--interpreter=vscode" },
        }
        -- function form so configs coming from .vscode/launch.json (see vscode-launch.lua)
        -- can be missing "args" and still work
        dap.adapters.coreclr = function(callback, config)
            config.args = config.args or {}
            callback(coreclr_adapter)
        end
        dap.adapters.netcoredbg = dap.adapters.coreclr

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "Launch - netcoredbg",
                request = "launch",
                program = function()
                    vim.cmd [[!dotnet build]]

                    local current_file_path = vim.api.nvim_buf_get_name(0)
                    local cwd = vim.fn.getcwd()

                    -- The index of the first / after cwd.
                    local end_index = string.find(current_file_path, "/", string.len(cwd) + 2)
                    local dll_path
                    if end_index == nil then
                        local project_name = string.sub(cwd, string.find(cwd, "/[^/]*$") + 1)
                        dll_path = cwd .. "/bin/Debug/net8.0/" .. project_name .. ".dll"
                    else
                        local project_name = string.sub(current_file_path, string.len(cwd) + 2, end_index - 1)
                        dll_path = cwd .. "/" .. project_name .. "/bin/Debug/net8.0/" .. project_name .. ".dll"
                    end

                    return custom_function.return_if_exists_else_ask(dll_path)
                end,
            },
            {
                type = "coreclr",
                name = "Attach to process",
                request = "attach",
                processId = "${command:pickProcess}"
            }
        }

        -- Firefox

        dap.adapters.firefox = {
            type = "executable",
            command = "node",
            args = { vim.fn.expand("$MASON/packages/firefox-debug-adapter/dist/adapter.bundle.js") }
        }
        local pwa_node_adapter = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {
                    vim.fn.expand("$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
                    "${port}",
                }
            }
        }
        dap.adapters["pwa-node"] = pwa_node_adapter

        -- VS Code's "node-terminal" launch type (see vscode-launch.lua) has no debug
        -- protocol of its own -- it's just a shell "command" string. Translate it into
        -- a pwa-node launch here, before pwa-node's own adapter resolves.
        dap.adapters["node-terminal"] = function(callback, config)
            local parts = vim.split(config.command, "%s+")
            config.type = "pwa-node"
            config.runtimeExecutable = parts[1]
            config.runtimeArgs = vim.list_slice(parts, 2)
            config.console = config.console or "integratedTerminal"
            config.skipFiles = config.skipFiles or { "<node_internals>/**" }
            callback(pwa_node_adapter)
        end

        -- Force node processes into a real OS terminal window instead of an
        -- integrated split, regardless of what "console" a launch config asks for.
        dap.defaults["pwa-node"].force_external_terminal = true
        dap.defaults["pwa-node"].external_terminal = {
            command = "cmd.exe",
            args = { "/c", "start", "cmd.exe", "/k" },
        }

        -- Python

        if require("custom-functions").is_nixos() then
            require("dap-python").setup("debugpy")
        else
            local debugpy = vim.fn.expand("$MASON/packages/debugpy/venv/Scripts/python.exe")
            require("dap-python").setup(debugpy)
        end

        -- C/C++

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = custom_function.debug_c_or_cpp,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Launch with input file",
                type = "gdb",
                request = "launch",
                program = custom_function.debug_c_or_cpp,
                args = function()
                    local args_str = vim.fn.input({
                        prompt = "File name (input.txt): ",
                    })
                    if string.len(args_str) == 0 then
                        args_str = "input.txt"
                    end
                    return "<" .. args_str
                end,
            },
        }
        dap.configurations.c = dap.configurations.cpp


        -- Rust

        dap.adapters["rust-gdb"] = {
            type = "executable",
            command = "rust-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
            name = "rust-gdb",
        }
        dap.configurations.rust = {
            {
                name = "Launch",
                type = "rust-gdb",
                request = "launch",
                program = custom_function.debug_rust,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Launch with arguments",
                type = "rust-gdb",
                request = "launch",
                program = custom_function.debug_rust,
                args = function()
                    local args_str = vim.fn.input({
                        prompt = "Arguments: ",
                    })
                    return args_str
                end,
            },
            {
                name = "Launch with input file",
                type = "rust-gdb",
                request = "launch",
                program = custom_function.debug_rust,
                args = function()
                    local args_str = vim.fn.input({
                        prompt = "File name (input.txt): ",
                    })
                    if string.len(args_str) == 0 then
                        args_str = "input.txt"
                    end
                    return "<" .. args_str
                end,
            },
        }

        vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
    keys = {
        { "<F5>",  function() require("dap").continue() end,                desc = "Continue Testing" },
        { "<F6>",  function() require("vscode-launch").pick_and_run_compound() end, desc = "Launch VS Code compound" },
        { "<F7>",  require("custom-functions").conditional_breakpoint,      desc = "Conditional breakpoint" },
        { "<F8>",  function() require("dap").terminate({ all = true }) end, desc = "Terminate All Sessions" },
        { "<F9>",  function() require("dap").toggle_breakpoint() end,       desc = "Toggle Breakpoint" },
        { "<F10>", function() require("dap").step_over() end,               desc = "Step Over" },
        { "<F11>", function() require("dap").step_into() end,               desc = "Step Into" },
        { "<F12>", function() require("dap").step_out() end,                desc = "Step Out" },
    },
}
