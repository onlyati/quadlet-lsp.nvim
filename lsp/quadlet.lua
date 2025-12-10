---@type vim.lsp.Config
return {
    cmd = { "quadlet-lsp" },
    filetypes = { "quadlet" },
    root_dir = function(bufnr, on_dir)
        local root_dir = vim.fs.root(bufnr, { ".quadletrc.json", ".git" })
        if root_dir ~= nil then
            on_dir(root_dir)
        else
            on_dir(vim.loop.cwd())
        end
    end,

    handlers = {
        ["window/showMessage"] = function(_, result, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            local client_name = (client and client.name) or "quadlet-lsp.nvim"
            local level = ({
                [vim.lsp.protocol.MessageType.Error] = vim.log.levels.ERROR,
                [vim.lsp.protocol.MessageType.Warning] = vim.log.levels.WARN,
                [vim.lsp.protocol.MessageType.Info] = vim.log.levels.INFO,
                [vim.lsp.protocol.MessageType.Log] = vim.log.levels.DEBUG,
            })[result.type] or vim.log.levels.INFO

            vim.notify(string.format("[%s] %s", client_name, result.message), level)
        end,
    },
}
