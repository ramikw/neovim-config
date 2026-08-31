local max_path_length = 45
local M = {}

function M.go_to_definition()
    vim.lsp.buf.definition()
end

function M.debug_test()
    require("neotest").run.run({
        strategy = "dap",
        suite = false,
    })
end

function M.run_all_tests()
    require("neotest").run.run(vim.fn.getcwd())
end

function M.file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function M.load_coverage()
    require("coverage").clear()
    require("coverage").load()
end

function M.show_coverage_summary()
    M.load_coverage()
    require("coverage").summary()
end

function M.toggle_test_summary()
    require("neotest").summary.toggle()
end

function M.run_marked_tests()
    require("neotest").summary.run_marked()
end

-- Async: calls `cb` with the resolved path, prompting only when `path` is missing.
-- `cb` receives nil if the user cancels the prompt.
function M.resolve_executable(path, cb)
    if M.file_exists(path) then
        cb(path)
    else
        vim.ui.input({
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            completion = "file",
        }, cb)
    end
end

-- nvim-dap resolves config values inside a coroutine, so returning one lets us
-- prompt without blocking: vim.fn.input halts the whole editor until answered,
-- which looks like a freeze when the prompt is hidden behind noice's cmdline.
function M.return_if_exists_else_ask(path)
    return coroutine.create(function(dap_run_co)
        M.resolve_executable(path, function(result)
            coroutine.resume(dap_run_co, result)
        end)
    end)
end

-- Runs a build command without blocking the UI, then continues via `on_success`.
-- The old `vim.cmd[[!cargo build]]` froze nvim for the entire build.
local function build_then(cmd, on_success)
    vim.notify("Running " .. table.concat(cmd, " ") .. "...", vim.log.levels.INFO)
    vim.system(cmd, { cwd = vim.fn.getcwd(), text = true }, function(res)
        vim.schedule(function()
            if res.code ~= 0 then
                vim.notify(
                    table.concat(cmd, " ") .. " failed:\n" .. (res.stderr or res.stdout or ""),
                    vim.log.levels.ERROR
                )
            end
            on_success(res.code == 0)
        end)
    end)
end

function M.get_folder_name(path)
    return string.sub(path, string.find(path, "/[^/]*$") + 1)
end

-- Builds, then resolves the executable, then hands the path back to nvim-dap.
-- Aborts the launch (resume with nil) if the build fails.
local function build_and_resolve(cmd, target)
    return coroutine.create(function(dap_run_co)
        build_then(cmd, function(ok)
            if not ok then
                coroutine.resume(dap_run_co, nil)
                return
            end
            M.resolve_executable(target, function(result)
                coroutine.resume(dap_run_co, result)
            end)
        end)
    end)
end

function M.debug_c_or_cpp()
    return build_and_resolve(
        { "g++", "main.cpp", "-o", "main", "-g" },
        vim.fn.getcwd() .. "/" .. "main"
    )
end

function M.debug_rust()
    return build_and_resolve(
        { "cargo", "build" },
        vim.fn.getcwd() .. "/target/debug/" .. M.get_folder_name(vim.fn.getcwd())
    )
end

function M.is_windows()
    return vim.fn.has("win32") == 1
end

function M.conditional_breakpoint()
    vim.ui.input({ prompt = "Condition" }, function(condition)
        if condition ~= nil and string.len(condition) > 0 then
            require("dap").set_breakpoint(condition)
        end
    end)
end

return M
