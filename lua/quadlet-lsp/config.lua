local M = {}
local util = require("quadlet-lsp.util")

function M.setup(opts)
	-- Set default LSP path if not provided
	opts.cmd = opts.cmd or { "quadlet-lsp" } -- Default to looking in PATH

	-- Verify LSP binary exists
	if not util.has_lsp_binary(opts.cmd[1]) then
		vim.notify(
			string.format("quadlet-lsp binary not found at '%s'. Please install it.", opts.cmd[1]),
			vim.log.levels.ERROR
		)
		return
	end

	-- Registrer LSP commands
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

	-- Register LSP config
	vim.lsp.config("quadlet-lsp", {
		cmd = opts.cmd,
		filetypes = { "quadlet" },

		root_dir = function(_, on_dir)
			on_dir(vim.fn.getcwd())
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
	})

	-- Auto-start based on filetype/root
	vim.lsp.enable("quadlet-lsp")
end

return M
