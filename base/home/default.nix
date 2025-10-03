{ config, lib, userName, stateVersion, ... }:

{
  imports = [
    ./xdg.nix
  ];

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = stateVersion;
  };

  programs.home-manager.enable = true;
  home-manager.backupFileExtension = "backup";
}
