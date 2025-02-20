{ config, pkgs, ... }:

{
  home.username = "sdev";
  home.homeDirectory = "/home/sdev";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    htop
  ];

  # Включение браузеров из общих модулей
  firefox.enable = true;
  google-chrome.enable = true;

  programs.bash.enable = true;
  programs.git.enable = true;
}