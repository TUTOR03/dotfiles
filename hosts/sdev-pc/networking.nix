{ lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    # interfaces.wlo1.useDHCP = lib.mkDefault true;
  };
}