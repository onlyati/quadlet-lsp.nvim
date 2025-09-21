local M = {}

---Configure commands for the language server
function M.init()
	vim.api.nvim_create_user_command("QuadletPullAll", function()
		vim.lsp.buf_request(0, "workspace/executeCommand", {
			command = "pullAll",
			arguments = {},
		})
	end, {})

	vim.api.nvim_create_user_command("QuadletListJobs", function()
		vim.lsp.buf_request(0, "workspace/executeCommand", {
			command = "listJobs",
			arguments = {},
		})
	end, {})
end

return M
