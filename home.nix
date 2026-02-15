{ pkgs, ... }:

{
  home.stateVersion = "25.11";
  xdg.enable = true;

  imports = [
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/jujutsu.nix
  ];

  home.packages = with pkgs; [
    tmux
    skim
    zoxide
    delta
    ripgrep
    uv
    cloudflared
    cmake
    ffmpeg
    # jq
    wget
    tree

    zig
    go
    SDL2
  ];
}
