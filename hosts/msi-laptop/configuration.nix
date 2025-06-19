{ config, hostname, username, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
  ];

  powerManagement.enable = true;
  services.logind.lidSwitch = "suspend";

  services = {
    libinput.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };

    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
      defaultSession = "plasma";
    };
  };
  
  power-profiles-daemon.enable = true;
}
