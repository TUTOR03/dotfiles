{ config, pkgs, ... }:

let
  hostname = "astukalov-thinkpad";
  username = "astukalov";
in
{
  imports = [
    ./home-modules
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#${hostname}";
      rebuild-home = "home-manager switch --flake ${config.home.homeDirectory}/dotfiles#${username}@${hostname}";
    };
  };

  # Рабочий стол - Hyprland
  hyprland.enable = true;

  # Пакеты, которые не тербуют доп конфигурации
  home.packages = with pkgs; [
    # Терсинал
    ghostty
    # Сеть
    dig
    dnsutils
    networkmanagerapplet
    # Bluetooth
    blueman
    # Заметки
    obsidian
    # Медиа
    nomacs
    audacity
    # Браузеры
    firefox
    # Другое
    texlive.combined.scheme-full
    nixpkgs-fmt
    obs-studio
    neofetch
    htop
  ];

  # SSH и Git
  ssh = {
    enable = true;
    keys = [ "~/.ssh/id_rsa_thinkpad_github" "~/.ssh/id_rsa_thinkpad_vk_gitlab" ];
  };
  git = {
    enable = true;
    userName = "TUTOR03";
    userEmail = "stukalov.dev@gmail.com";
  };

  # Браузеры
  google-chrome.enable = true;

  # Редакторы кода
  vscode.enable = true;
  zed.enable = true;

  # Языки
  nodejs = {
    enable = true;
    versions = with pkgs; [ nodejs_20 ];
  };
  rust.enable = true;

  # Прочее
  thunar.enable = true;
  vlc.enable = true;

  sops.enable = true;
  vkvpn = {
    enable = true;
    caPath = config.sops.secrets."ca.crt".path;
    tlsAuthPath = config.sops.secrets."ta.key".path;
    pkcs11IdPath = config.sops.secrets.pkcs11-id.path;
  };
}
