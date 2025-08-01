local M = {}

function M.has_lsp_binary(bin_name)
    if vim.fn.executable(bin_name) == 1 then
        return true
    end

    -- Check if it exists as a path
    if vim.fn.filereadable(bin_name) == 1 then
        return true
    end

    return false
end

return M
