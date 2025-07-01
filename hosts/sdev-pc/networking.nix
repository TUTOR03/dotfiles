{ lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    interfaces.enp12s0.useDHCP = lib.mkDefault true;
    interfaces.wlp13s0.useDHCP = lib.mkDefault true;
  };
}
