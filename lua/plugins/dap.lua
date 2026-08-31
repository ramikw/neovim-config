local function pick_session(prompt, on_choice)
    local dap = require("dap")
    local sessions = dap.sessions()
    local items = {}
    for _, s in pairs(sessions) do
        table.insert(items, s)
    end
    if #items == 0 then
        vim.notify("No active debug sessions", vim.log.levels.WARN)
        return
    end
    if #items == 1 then
        on_choice(items[1])
        return
    end
    vim.ui.select(items, {
        prompt = prompt,
        format_item = function(s)
            local current = (dap.session() and dap.session().id == s.id) and " (current)" or ""
            return s.config.name .. current
        end,
    }, function(choice)
        if choice then on_choice(choice) end
    end)
end

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
            command = custom_function.is_windows()
                and vim.fn.expand("$MASON/packages/netcoredbg/netcoredbg/netcoredbg.exe")
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

        -- netcoredbg on Windows only resolves breakpoints when the source path
        -- uses backslashes, and buffer names in nvim always use forward slashes.
        -- Without this, every breakpoint stays unverified with "No symbols have
        -- been loaded for this document". Paths netcoredbg sends back are
        -- normalized by nvim itself, so only the outgoing direction needs fixing.
        if custom_function.is_windows() then
            dap.listeners.on_session["netcoredbg-backslash-paths"] = function(_, session)
                local type = session and session.config and session.config.type
                -- on_session fires again whenever dap switches active session
                if (type ~= "coreclr" and type ~= "netcoredbg") or session.netcoredbg_paths_patched then
                    return
                end
                session.netcoredbg_paths_patched = true
                local request = session.request
                session.request = function(self, command, arguments, on_result)
                    if command == "setBreakpoints" and arguments.source and arguments.source.path then
                        arguments.source.path = arguments.source.path:gsub("/", "\\")
                    end
                    return request(self, command, arguments, on_result)
                end
            end
        end

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

        local debugpy = vim.fn.expand("$MASON/packages/debugpy/venv/Scripts/python.exe")
        require("dap-python").setup(debugpy)

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

        -- Adding overseer integration
        require("overseer").enable_dap()
    end,
    keys = {
        { "<leader>dh", function() require("dap.ui.widgets").hover() end,   desc = "Debug Hover" },
        { "<leader>ds", function()
            pick_session("Select debug session:", function(choice)
                require("dap").set_session(choice)
            end)
        end, desc = "Pick Debug Session" },
        { "<F5>",  function() require("dap").continue() end,                desc = "Continue Testing" },
        { "<F6>",  function() require("vscode-launch").pick_and_run_compound() end, desc = "Launch VS Code compound" },
        { "<F7>",  function() require("custom-functions").conditional_breakpoint() end, desc = "Conditional breakpoint" },
        { "<F8>",  function() require("dap").terminate({ all = true }) end, desc = "Terminate All Sessions" },
        { "<leader>dr", function()
            pick_session("Restart debug session:", function(choice)
                local dap = require("dap")
                dap.set_session(choice)
                dap.restart()
            end)
        end, desc = "Restart Debug Session" },
        { "<F9>",  function() require("dap").toggle_breakpoint() end,       desc = "Toggle Breakpoint" },
        { "<F10>", function() require("dap").step_over() end,               desc = "Step Over" },
        { "<F11>", function() require("dap").step_into() end,               desc = "Step Into" },
        { "<F12>", function() require("dap").step_out() end,                desc = "Step Out" },
    },
}
