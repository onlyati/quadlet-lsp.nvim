# Quadlet LSP Neovim plugin

This is a plugin for [Podman Quadlet LSP](https://github.com/onlyati/quadlet-lsp/).

Setup for the plugin with `lazy.nvim`:

```lua
return {
    "onlyati/quadlet-lsp.nvim",
    lazy = false,
    config = function()
        require("quadlet-lsp").setup({
            -- If `quadlet-lsp` is not on path by default
            -- you can specify its path (optional)
            cmd = { "/home/ati/work/quadlet-lsp/bin/quadlet-lsp" },
        })
    end,
}
```
