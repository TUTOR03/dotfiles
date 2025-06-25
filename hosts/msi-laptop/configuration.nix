{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./services.nix
    ./networking.nix
  ];

  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };

  powerManagement.enable = true;
}
