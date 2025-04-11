{ config, pkgs, ... }:

{
  home.username = "sdev";
  home.homeDirectory = "/home/sdev";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    htop
    jetbrains-mono
  ];

  # Включение ssh и git
  ssh = {
    enable = true;
    keys = [
      "~/.ssh/id_rsa_msi_laptop_github"
    ];
  };
  git = {
    enable = true;
    sshKeyPathGithub = "~/.ssh/id_rsa_msi_laptop_github";
  };

  # Включаем редакторы кода
  vscode.enable = true;

  # Включаем языки
  nodejs = {
    enable = true;
    versions = with pkgs; [ nodejs_20 ];
  };
  rust.enable = true;

  # Включаем браузеры
  firefox.enable = true;
  google-chrome.enable = true;

  # Включаем VLC плеер
  vlc.enable = true;

  # Включаем Steam
  steam.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#msi-laptop";
      "rebuild-home" = "home-manager switch --flake ${config.home.homeDirectory}/dotfiles#sdev@msi-laptop";
    };
  };

  # Включаем Hyprland
  hyprland.enable = true;

  fonts.fontconfig.enable = true;

  # Настройка программ по умолчанию
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Видео открываются в VLC
      "video/mp4" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/avi" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";

      # Браузер по умолчанию для HTTP/HTTPS/HTML
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "text/html" = "google-chrome.desktop";
      "application/xhtml+xml" = "google-chrome.desktop";
    };
  };

  # Переменные окружения
  home.sessionVariables = {
    BROWSER = "google-chrome";
    DEFAULT_BROWSER = "google-chrome";
    NIXOS_OZONE_WL = "1";
  };
}
