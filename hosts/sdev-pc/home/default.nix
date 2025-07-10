{ config, lib, hostName, userName, userEmail, pkgs, ... }:

{
  imports = [
    ./sops.nix
  ];

  home.stateVersion = "25.05";

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  home.packages = with pkgs; [
    firefox
    google-chrome
    git
    git-lfs
    git-extras
    nixpkgs-fmt
    htop
    sops
    obsidian
    discord
    audacity
    vlc
    obs-studio
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#${hostName}";
    };
  };

  programs.starship.enable = true;

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
      lockOnStartup = true;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      timeout = 30;
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;
        powerButtonAction = "sleep";
        powerProfile = "performance";
        turnOffDisplay = {
          idleTimeout = 1800;
          idleTimeoutWhenLocked = 900;
        };
        whenSleepingEnter = "standby";
      };
      general.pausePlayersOnSuspend = true;
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
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
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
      edgeBarrier = 0;
      effects = {
        shakeCursor.enable = false;
        blur.enable = false;
        desktopSwitching.animation = "slide";
      };
    };

    input.keyboard = {
      switchingPolicy = "global";
      layouts = [
        {
          layout = "us";
          displayName = "EN";
        }
        {
          layout = "ru";
          displayName = "RU";
        }
      ];
    };


    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "GruvboxDark";
      shell-integration = "zsh";
    };
  };

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
      "fi-vpn" = {
        user = "vpn";
        hostname = "43.245.225.116";
        port = 22;
        identityFile = config.sops.secrets."ssh/fi-vpn/private".path;
      };
    };
  };

  vscode.enable = true;
  zed.enable = true;
}
