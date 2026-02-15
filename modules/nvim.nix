{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # No plugins needed for nil in nvim 0.11+
    plugins = [ ];
  };

  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  home.packages = with pkgs; [
    nixd
    nixfmt
    lua-language-server
  ];
}
