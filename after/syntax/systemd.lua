local exts = {
	container = true,
	volume = true,
	network = true,
	pod = true,
	image = true,
	build = true,
	kube = true,
	artifact = true,
}

local ext = vim.fn.expand("%:e")
if exts[ext] then
	vim.bo.filetype = "quadlet"
end
