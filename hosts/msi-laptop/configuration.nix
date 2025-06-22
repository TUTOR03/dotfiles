{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./services.nix
    ./networking.nix
  ];

  powerManagement.enable = true;
}
