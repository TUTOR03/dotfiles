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
  git = {
    enable = true;
    sshKeyPathGithub = "~/.ssh/id_rsa_msi_laptop_github";
  };

  # Включаем редакторы кода
  vscode.enable = true;

  # Включение браузеров из общих модулей
  firefox.enable = true;
  google-chrome.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake .#msi-laptop";
      "rebuild-home" = "home-manager switch --flake .#sdev@msi-laptop";
    };
  };
}