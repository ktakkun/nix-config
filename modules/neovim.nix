{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

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
           -- vim.lsp.config("nixd", {
           --   cmd = { "nixd" },
           --  settings = {
           --     nixd = {
           --       flake = {
           --         -- autoArchive = true,
           --       },
           --     },
           --   },
           -- })
            vim.lsp.enable("nixd")

      vim.o.completeopt = "menu,menuone,noinsert"

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
    nixd
    nixfmt-rfc-style
  ];

}
