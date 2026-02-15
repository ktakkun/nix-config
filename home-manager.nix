{ pkgs, ... }:

{
  home.stateVersion = "25.11";
  xdg.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # No plugins needed for nil in nvim 0.11+
    plugins = [ ];

    initLua = ''
      vim.o.expandtab = true
      vim.o.shiftwidth = 2
      vim.o.tabstop = 2

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        callback = function()
          vim.bo.expandtab = true
          vim.bo.shiftwidth = 2
          vim.bo.tabstop = 2
        end,
      })

      -- Neovim 0.11+ native LSP config
      vim.lsp.config("nil_ls", {
        cmd = { "nil" },
        settings = {
          ["nil"] = {
            flake = {
              -- autoArchive = true,
            },
          },
        },
      })
      vim.lsp.enable("nil_ls")

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.nix",
        callback = function()
          local view = vim.fn.winsaveview()
          vim.cmd("%!nixfmt")
          vim.fn.winrestview(view)
        end,
      })
    '';
  };

  home.packages = with pkgs; [
    tmux
    skim
    zoxide
    delta
    ripgrep
    uv

    go
    SDL2

    nil
    nixfmt
  ];
}
