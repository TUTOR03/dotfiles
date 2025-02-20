{ config, pkgs, ... }:

{
  home.username = "sdev";
  home.homeDirectory = "/home/sdev";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    htop
    google-chrome
  ];

  programs.bash.enable = true;
}