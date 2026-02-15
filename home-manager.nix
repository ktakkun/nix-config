{ pkgs, ... }:

{
  home.stateVersion = "25.11";
  xdg.enable = true;

  imports = [
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/jujutsu.nix
  ];

  programs.git = {
    enable = true;

    ignores = [ ".DS_Store" ];

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        name = "ktakkun";
        email = "9464677+ktakkun@users.noreply.github.com";
      };
    };
  };
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
