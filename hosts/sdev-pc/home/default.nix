{ config, lib, hostName, userName, userEmail, pkgs, ... }:

{
  imports = [
    ./sops.nix
  ];

  home.stateVersion = "25.05";

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#${hostName}";
    };
  };

  programs.plasma = {
    enable = true;

    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "breeze-dark";
      cursor = {
        size = 24;
        theme = "Breeze";
      };
    };

    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      timeout = 300;
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        height = 44;
        floating = false;
        hiding = "normalpanel";
        widgets = [
          { name = "org.kde.plasma.kickoff"; }
          { name = "org.kde.plasma.pager"; }
          { name = "org.kde.plasma.icontasks"; }
          { name = "org.kde.plasma.systemtray"; }
          { name = "org.kde.plasma.digitalclock"; }
        ];
      }
    ];

    shortcuts = {
      "kwin" = {
        "Switch One Desktop to the Right" = "Meta+PgUp";
        "Switch One Desktop to the Left" = "Meta+PgDown";
        "Window to Next Desktop" = "Meta+Shift+PgUp";
        "Window to Previous Desktop" = "Meta+Shift+PgDown";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
      };
    };

    kwin = {
      virtualDesktops = {
        number = 5;
        rows = 1;
        names = [ "1" "2" "3" "4" "5" ];
      };
    };

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
  };

  home.packages = with pkgs; [
    firefox
    google-chrome
    git
    git-lfs
    git-extras
    nixpkgs-fmt
    htop
    sops
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "TUTOR03";
    inherit userEmail;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = config.sops.secrets."ssh/github/private".path;
      };
    };
  };

  vscode.enable = true;
}
