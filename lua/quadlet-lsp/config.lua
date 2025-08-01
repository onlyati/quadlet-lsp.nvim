local M = {}
local util = require("quadlet-lsp.util")

function M.setup(opts)
	-- Set default LSP path if not provided
	opts.cmd = opts.cmd or { "quadlet-lsp " } -- Default to looking in PATH

	-- Register filetypes first
	vim.filetype.add({
		extension = {
			container = "quadlet",
			volume = "quadlet",
			network = "quadlet",
			pod = "quadlet",
			image = "quadlet",
			build = "quadlet",
			kube = "quadlet",
		},
	})

	-- Setup autocommands
	vim.api.nvim_create_autocmd({ "BufReadPost", "VimEnter" }, {
		pattern = { "*.container", "*.volume", "*.network", "*.pod", "*.image", "*.build", "*.kube" },
		callback = function()
			vim.bo.filetype = "quadlet"
			vim.bo.syntax = "systemd"
		end,
	})

	-- Verify LSP binary exists
	if not util.has_lsp_binary(opts.cmd[1]) then
		vim.notify(
			string.format("quadlet-lsp binary not found at '%s'. Please install it.", opts.cmd[1]),
			vim.log.levels.ERROR
		)
		return
	end

	-- Register LSP config
	require("lspconfig.configs").quadlet_lsp = {
		default_config = {
			cmd = opts.cmd,
			filetypes = { "quadlet" },
			root_dir = function(_)
				return vim.fn.getcwd()
			end,
			handlers = {
				["window/showMessage"] = function(_, result, ctx)
					local client = vim.lsp.get_client_by_id(ctx.client_id)
					local client_name = client and client.name or "quadlet-lsp.nvim "
					local level = ({
						[vim.lsp.protocol.MessageType.Error] = vim.log.levels.ERROR,
						[vim.lsp.protocol.MessageType.Warning] = vim.log.levels.WARN,
						[vim.lsp.protocol.MessageType.Info] = vim.log.levels.INFO,
						[vim.lsp.protocol.MessageType.Log] = vim.log.levels.DEBUG,
					})[result.type] or vim.log.levels.INFO

					vim.notify(string.format("[%s] %s", client_name, result.message), level)
				end,
			},
		},
	}

	-- Start LSP client
	require("lspconfig").quadlet_lsp.setup({})
end

return M
