{ config, pkgs, ... }:

{
  home.username = "astukalov";
  home.homeDirectory = "/home/astukalov";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    BROWSER = "google-chrome";
    DEFAULT_BROWSER = "google-chrome";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    nerdfonts
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#astukalov-thinkpad";
      rebuild-home = "home-manager switch --flake ${config.home.homeDirectory}/dotfiles#astukalov@astukalov-thinkpad";
      nix-gc = "sudo nix-collect-garbage";
      nix-gc-boot = ''
        sudo nix-collect-garbage --delete-older-than 7d && \
        sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d && \
        sudo /run/current-system/bin/switch-to-configuration boot
      '';
      hypr-reload = ''
        pkill waybar && \
        hyprctl reload && \
        waybar & disown
      '';
    };
  };

  fonts.fontconfig.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/avi" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "text/html" = "google-chrome.desktop";
      "application/xhtml+xml" = "google-chrome.desktop";
    };
  };

  # Настройка SSH и Git
  ssh = {
    enable = true;
    keys = [ "~/.ssh/id_rsa_thinkpad_github" ];
  };
  git = {
    enable = true;
    sshKeyPathGithub = "~/.ssh/id_rsa_thinkpad_github";
    userName = "TUTOR03";
    userEmail = "stukalov.dev@gmail.com";
  };

  # Редакторы кода
  vscode.enable = true;

  # Языки программирования
  nodejs = {
    enable = true;
    versions = with pkgs; [ nodejs_20 ];
  };
  rust.enable = true;

  # Браузеры
  firefox.enable = true;
  google-chrome.enable = true;

  # Медиа программы
  vlc.enable = true;
  audacity.enable = true;
  nomacs.enable = true;

  # Рабочий стол
  hyprland.enable = true;

  # Прочие программы
  obs.enable = true;
  htop.enable = true;
  neofetch.enable = true;
}