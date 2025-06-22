{ config, lib, hostName, userName, userEmail, pkgs , ... }:

{
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
    };

    kwin = {
      virtualDesktops = {
        number = 5;
        rows = 1;
        names = [ "1" "2" "3" "4" "5" ];
      };
    };
  };

  home.packages = with pkgs; [
    firefox
    git
    git-lfs
    git-extras
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    inherit userName userEmail;
  };

  programs.ssh = {
    enable = true;
  };
}