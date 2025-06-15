{ config, hostname, username, pkgs, pkgs-unstable, ... }:

{

  imports = [
    ./boot.nix
    ./hardware.nix
  ];

  powerManagement.enable = true;
  services.logind.lidSwitch = "suspend";
}
