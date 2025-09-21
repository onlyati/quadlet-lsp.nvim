local M = {}

---@class Config
---@field cmd string

---Default config
---@type Config
M.opts = {
	cmd = "quadlet-lsp",
}

---Main entrypoint of the plugin
---@param opts Config|nil
function M.setup(opts)
	-- Merge default config with provided one
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

	-- Verify language server and reconfigure if needed
	local lsp_config = require("quadlet-lsp.lsp")
	if not lsp_config.found(M.opts) then
		return
	end
	lsp_config.reconfigure(M.opts)
	vim.lsp.enable("quadlet")

	-- Setup lanuage server commands
	require("quadlet-lsp.commands").init()
end

return M
