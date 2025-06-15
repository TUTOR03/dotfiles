{ config, hostname, username, pkgs, pkgs-unstable, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.plasma = {
    enable = true;
  };

  home.packages = with pkgs; [
    neofetch
    htop
  ];
}
