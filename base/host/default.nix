{ config, lib, stateVersion, ... }:

{
  imports = [
    ./hardware.nix
    ./network.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
    ./services.nix
    ./user.nix
  ];

  system.stateVersion = stateVersion;
}
