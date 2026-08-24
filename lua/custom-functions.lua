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

function M.return_if_exists_else_ask(path)
    if M.file_exists(path) then
        return path
    else
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end
end

function M.get_folder_name(path)
    return string.sub(path, string.find(path, "/[^/]*$") + 1)
end

function M.debug_c_or_cpp()
    vim.cmd [[!g++ main.cpp -o main -g]]
    return M.return_if_exists_else_ask(vim.fn.getcwd() .. "/" .. "main")
end

function M.debug_rust()
    vim.cmd [[!cargo build]]
    return M.return_if_exists_else_ask(
        vim.fn.getcwd()
        .. "/target/debug/"
        .. M.get_folder_name(vim.fn.getcwd()))
end

function M.get_buffer_relative_path()
    local file_path = vim.api.nvim_buf_get_name(0)
    local path = string.sub(file_path, string.len(vim.fn.getcwd()) + 2)
    if string.len(path) > max_path_length then
        return ".." .. string.sub(path, string.len(path) - max_path_length, string.len(path))
    else
        return path
    end
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
