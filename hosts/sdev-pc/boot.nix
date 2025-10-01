{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "xhci_pci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };

    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "nvidia-drm.modeset=1" ];
  };
}
