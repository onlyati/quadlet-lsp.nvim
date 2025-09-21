local M = {}

---Return with true of language server found else false.
---If not found it also issue an error notification.
---@param opts Config
---@return boolean
function M.found(opts)
	if vim.fn.executable(opts.cmd) == 0 then
		vim.notify(
			string.format("quadlet-lsp binary not found at '%s'. Please install it.", opts.cmd),
			vim.log.levels.ERROR
		)
		return false
	end
	return true
end

---Reconfigure the lsp setup if something needs to be changes from config.
---@param opts Config
function M.reconfigure(opts)
	-- Override command if specified
	if opts.cmd ~= "quadlet-lsp" then
		vim.lsp.config("quadlet", {
			cmd = { opts.cmd },
		})
	end
end

return M
