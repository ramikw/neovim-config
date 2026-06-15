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
    vim.cmd("CoverageClear")
    vim.cmd("Coverage")
end

function M.show_coverage_summary()
    M.load_coverage()
    vim.cmd("CoverageSummary")
end

function M.toggle_test_summary()
    vim.cmd("Neotest summary")
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
    if string.find(file_path, "neo-tree") then
        return "File Tree"
    else
        local path = string.sub(file_path, string.len(vim.fn.getcwd()) + 2)
        if string.len(path) > max_path_length then
            return ".." .. string.sub(path, string.len(path) - max_path_length, string.len(path))
        else
            return path
        end
    end
end

function M.is_nixos()
    local handle = io.popen("uname -a")
    if handle == nil then
        return false
    end
    local os_name = string.lower(handle:read("*a"))
    return string.find(os_name, "nixos") ~= nil
end

function M.is_windows()
    return vim.fn.has("win32") == 1
end

function M.hover()
    if require("dap").session() == nil then
        vim.lsp.buf.hover({
            max_width = 80,
            max_height = 20,
        })
    else
        require("dap.ui.widgets").hover()
    end
end

function M.conditional_breakpoint()
    vim.ui.input({ prompt = "Condition" }, function(condition)
        if condition ~= nil and string.len(condition) > 0 then
            require("dap").set_breakpoint(condition)
        end
    end)
end

function M.add_cs_documentation_comment(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
        vim.api.nvim_create_autocmd("InsertCharPre", {
            desc = "Roslyn: Trigger an auto insert on '/'.",
            buffer = bufnr,
            callback = function()
                local char = vim.v.char

                if char ~= "/" then
                    return
                end

                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                row, col = row - 1, col + 1
                local uri = vim.uri_from_bufnr(bufnr)

                local params = {
                    _vs_textDocument = { uri = uri },
                    _vs_position = { line = row, character = col },
                    _vs_ch = char,
                    _vs_options = {
                        tabSize = vim.bo[bufnr].tabstop,
                        insertSpaces = vim.bo[bufnr].expandtab,
                    },
                }

                -- NOTE: We should send textDocument/_vs_onAutoInsert request only after
                -- buffer has changed.
                vim.defer_fn(function()
                    client:request(
                    ---@diagnostic disable-next-line: param-type-mismatch
                        "textDocument/_vs_onAutoInsert",
                        params,
                        function(err, result, _)
                            if err or not result then
                                return
                            end

                            vim.snippet.expand(result._vs_textEdit.newText)
                        end,
                        bufnr
                    )
                end, 1)
            end,
        })
    end
end

function M.update_cs_diagnostics()
    local clients = vim.lsp.get_clients({ name = "roslyn" })
    if not clients or #clients == 0 then
        return
    end
    for _, client in ipairs(clients) do
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf)
                and #vim.lsp.get_clients({ name = "roslyn", bufnr = buf }) > 0
            then
                local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
                client:request("textDocument/diagnostic", params, nil, buf)
            end
        end
    end
end

return M
