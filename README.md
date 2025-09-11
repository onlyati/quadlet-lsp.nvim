# Quadlet LSP Neovim plugin

This is a plugin for
[Podman Quadlet LSP](https://github.com/onlyati/quadlet-lsp/).

> [!NOTE]
>
> Open your issues/questions in the `onlyati/quadlet-lsp` repository.

Work with `>=0.10` Neovim with tree-sitter. Setup for the plugin with
`lazy.nvim`:

```lua
{
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

## Commands

- `QuadletPullAll`: Looking for all image in the current directory and if image
  is not present, execute `podman image pull <image>` command.
- `QuadletListJobs`: List running background jobs.
