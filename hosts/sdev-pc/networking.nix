{ lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    interfaces.enp12s0.useDHCP = lib.mkDefault true;
    interfaces.wlp13s0.useDHCP = lib.mkDefault true;

    firewall = {
      enable = false;
      allowedUDPPorts = [ 50000 65535 ];
    };
  };
}
