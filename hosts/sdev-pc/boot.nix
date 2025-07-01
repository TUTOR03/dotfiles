{ config, pkgs, modulesPath, ... }:

{
  imports =[(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      availableKernelModules = [ 
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ "dm-snapshot" ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };
}
