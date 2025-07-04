{ lib, config, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    opengl.enable = true;

    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      prime = {
        amdgpuBusId = "PCI:16:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
