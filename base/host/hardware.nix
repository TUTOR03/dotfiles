{ config, lib, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };
}
