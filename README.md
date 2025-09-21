# Quadlet LSP Neovim plugin

This is a plugin for
[Podman Quadlet LSP](https://github.com/onlyati/quadlet-lsp/).

> [!NOTE]
>
> Open your issues/questions in the `onlyati/quadlet-lsp` repository.

Work with `>=0.11` Neovim. Setup for the plugin with `lazy.nvim`:

```lua
{
    "onlyati/quadlet-lsp.nvim",
    lazy = false,
}
```

If `quadlet-lsp` binary cannot be found on path, pass `cmd` parameter:

```lua
{
    "onlyati/quadlet-lsp.nvim",
    lazy = false,
    opts = {
        cmd = "/home/ati/work/quadlet-lsp/bin/quadlet-lsp",
    }
}
```

## Commands

- `QuadletPullAll`: Looking for all image in the current directory and if image
  is not present, execute `podman image pull <image>` command.
- `QuadletListJobs`: List running background jobs.
