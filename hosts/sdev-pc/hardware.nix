{ lib, config, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # opengl.enable = true;

    # cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # nvidia = {
    #   open = false;
    #   package = config.boot.kernelPackages.nvidiaPackages.stable;
    #   modesetting.enable = true;
    #   powerManagement.enable = true;
    #   powerManagement.finegrained = true;
    #   nvidiaSettings = true;

    #   prime = {
    #     offload = {
    #       enable = true;
    #       enableOffloadCmd = true;
    #     };
    #     intelBusId = "PCI:0:2:0";
    #     nvidiaBusId = "PCI:46:0:0";
    #   };
    # };
  };
}
