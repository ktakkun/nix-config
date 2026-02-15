{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        name = "ktakkun";
        email = "9464677+ktakkun@users.noreply.github.com";
      };
    };

    ignores = [ ".DS_Store" ];
  };
}
