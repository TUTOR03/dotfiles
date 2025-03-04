{ config, pkgs, ... }:

{
  home.username = "sdev";
  home.homeDirectory = "/home/sdev";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    htop
  ];

  # Включение ssh и git
  ssh.enable = true;
  git.enable = true;

  # Включаем редакторы кода
  vscode.enable = true;

  # Включение браузеров из общих модулей
  firefox.enable = true;
  google-chrome.enable = true;

  programs.bash.enable = true;
}