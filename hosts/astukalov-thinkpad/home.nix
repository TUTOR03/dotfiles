{ config, pkgs, ... }:

{
  imports = [
    ./home-modules
  ];

  home.username = "astukalov";
  home.homeDirectory = "/home/astukalov";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    BROWSER = "google-chrome";
    DEFAULT_BROWSER = "google-chrome";
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Adwaita-dark";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.packages = with pkgs; [
    nerdfonts
    gnome-themes-extra
    adwaita-qt
    dig
    dnsutils
    hiddify-app
    nekoray
    texlive.combined.scheme-full
    networkmanagerapplet
    blueman
    obsidian
    wineWowPackages.stable
    winetricks
    corefonts
    dxvk
    fontconfig
    freetype
    heroic
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

  vkvpn = {
    enable = true;
    caPath = "${config.home.homeDirectory}/secrets/vk-vpn/ca.crt";
    tlsAuthPath = "${config.home.homeDirectory}/secrets/vk-vpn/ta.key";
    pkcs11IdFile = "${config.home.homeDirectory}/secrets/vk-vpn/pkcs11-id";
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
    keys = [ "~/.ssh/id_rsa_thinkpad_github" "~/.ssh/id_rsa_thinkpad_vk_gitlab" ];
  };
  git = {
    enable = true;
    userName = "TUTOR03";
    userEmail = "stukalov.dev@gmail.com";
  };

  # Редакторы кода
  vscode.enable = true;
  zed.enable = true;

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
  thunar.enable = true;

  steam.enable = true;
}
