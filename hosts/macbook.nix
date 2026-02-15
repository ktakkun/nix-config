{
  # config,
  # pkgs,
  # lib,
  ...
}:

let
  hostname = "tatsu-mac";
  username = "tatsu";
in
{
  networking.hostName = "${hostname}";

  users.users."${username}".home = "/Users/${username}";

  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nix.enable = false;

  security.pam.services.sudo_local.touchIdAuth = true;
}
