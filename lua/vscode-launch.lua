-- Reads .vscode/launch.json "compounds" and runs them via nvim-dap + overseer,
-- since nvim-dap has no native concept of compounds (dap.ext.vscode only loads
-- plain "configurations").
local M = {}

local function read_json(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*a")
    f:close()
    local ok, decoded = pcall(vim.json.decode, content)
    if not ok then
        vim.notify("Failed to parse " .. path .. ": " .. decoded, vim.log.levels.ERROR)
        return nil
    end
    return decoded
end

local function expand(value, workspace_folder)
    if type(value) == "string" then
        return (value:gsub("%${workspaceFolder}", workspace_folder))
    elseif type(value) == "table" then
        local out = {}
        for k, v in pairs(value) do
            out[k] = expand(v, workspace_folder)
        end
        return out
    end
    return value
end

local function load_launchjson()
    local workspace_folder = vim.fn.getcwd()
    local path = workspace_folder .. "/.vscode/launch.json"
    local data = read_json(path)
    if not data then
        vim.notify("No .vscode/launch.json found at " .. path, vim.log.levels.WARN)
        return nil
    end
    return expand(data, workspace_folder)
end

local function run_compound(data, compound)
    local configs_by_name = {}
    for _, cfg in ipairs(data.configurations or {}) do
        configs_by_name[cfg.name] = cfg
    end

    local function launch_all()
        for _, name in ipairs(compound.configurations) do
            local cfg = configs_by_name[name]
            if cfg then
                -- adapter-specific translation (e.g. node-terminal -> pwa-node) happens
                -- in dap.adapters itself, see plugins/dap.lua
                require("dap").run(cfg)
            else
                vim.notify(
                    "No configuration named '" .. name .. "' for compound '" .. compound.name .. "'",
                    vim.log.levels.WARN
                )
            end
        end
    end

    if compound.preLaunchTask then
        -- autostart = false so the subscriptions below are in place before the task
        -- runs; overseer starts the task before invoking this callback otherwise.
        require("overseer").run_task({ name = compound.preLaunchTask, autostart = false }, function(task, err)
            if not task then
                vim.notify(
                    "Could not start task '" .. compound.preLaunchTask .. "': " .. tostring(err),
                    vim.log.levels.ERROR
                )
                return
            end

            local STATUS = require("overseer.constants").STATUS

            -- A background/watch task (problemMatcher with a background end pattern)
            -- never completes, so it only ever reports through on_result. A plain task
            -- with a problemMatcher fires both, hence the one-shot guard.
            local done = false
            local function launch_once(ok)
                if done then
                    return
                end
                done = true

                if ok then
                    launch_all()
                else
                    vim.notify(
                        "preLaunchTask '" .. compound.preLaunchTask .. "' did not succeed, aborting compound",
                        vim.log.levels.ERROR
                    )
                end
            end

            task:subscribe("on_complete", function(_, status)
                launch_once(status == STATUS.SUCCESS)
                return false
            end)
            task:subscribe("on_result", function()
                launch_once(task.status ~= STATUS.FAILURE)
                return false
            end)

            task:start()
        end)
    else
        launch_all()
    end
end

function M.pick_and_run_compound()
    local data = load_launchjson()
    if not data or not data.compounds or vim.tbl_isempty(data.compounds) then
        vim.notify("No compounds found in launch.json", vim.log.levels.WARN)
        return
    end

    local names = {}
    for _, c in ipairs(data.compounds) do
        table.insert(names, c.name)
    end

    vim.ui.select(names, { prompt = "Launch compound:" }, function(choice)
        if not choice then
            return
        end
        for _, c in ipairs(data.compounds) do
            if c.name == choice then
                run_compound(data, c)
                return
            end
        end
    end)
end

return M
