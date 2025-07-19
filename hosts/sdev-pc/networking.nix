{ lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp12s0.useDHCP = false;
    interfaces.wlp13s0.useDHCP = lib.mkDefault true;

    firewall = {
      enable = false;
    };
  };
}
