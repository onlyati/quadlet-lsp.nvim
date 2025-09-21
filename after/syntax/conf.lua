-- Quadlet has possibility to have dropins directory.
-- In this directory files ends with '*.conf' and the parent directory
-- looks, for example, foo.container.d.
-- See: https://docs.podman.io/en/stable/markdown/podman-systemd.unit.5.html#description

local ext = vim.fn.expand("%:e")
local parent = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":t")

if
	ext == "conf"
	and (
		parent:match("image%.d$")
		or parent:match("container%.d$")
		or parent:match("volume%.d$")
		or parent:match("network%.d$")
		or parent:match("kube%.d$")
		or parent:match("pod%.d$")
		or parent:match("build%.d$")
	)
then
	vim.bo.filetype = "quadlet"
end
