{ ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };
}