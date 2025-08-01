local M = {}

function M.setup(opts)
    opts = opts or {}
    require("quadlet-lsp.config").setup(opts)
end

return M
