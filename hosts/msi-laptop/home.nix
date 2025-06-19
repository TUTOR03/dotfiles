{ config, hostname, username, pkgs, pkgs-unstable, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.plasma = {
    enable = true;

    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
    };

    kwin = {
      virtualDesktops = {
        number = 5;
        rows = 1;
        names = [ "1" "2" "3" "4" "5" ];
      };
    };

    shortcuts = {
      "kwin" = {
        "Walk Through Windows" = "Meta+Right";
        "Walk Through Windows Reverse" = "Meta+Left";
        "Walk Through Windows Up" = "Meta+Up";
        "Walk Through Windows Down" = "Meta+Down";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Switch to Previous Desktop" = "Meta+Page_Up";
        "Switch to Next Desktop" = "Meta+Page_Down";
        "Window to Previous Desktop" = "Meta+Shift+Page_Up";
        "Window to Next Desktop" = "Meta+Shift+Page_Down";
      };
    };
  };

  home.packages = with pkgs; [
    neofetch
    htop
    firefox
  ];
}
