{ pkgs, ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "ktakkun";
        email = "9464677+ktakkun@users.noreply.github.com";
      };
    };
  };
}
