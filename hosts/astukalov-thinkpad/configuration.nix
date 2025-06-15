{ config, hostname, username, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.initrd.luks.devices."luks-c237b1e9-8f18-4da1-88e2-96e5d857aac0".device = "/dev/disk/by-uuid/c237b1e9-8f18-4da1-88e2-96e5d857aac0";

  hyprland = {
    enable = true;
    inherit username;
  };

  openvpn.enable = true;
  services.libinput.enable = true;
  powerManagement.enable = true;
  services.logind.lidSwitch = "suspend";

  networking.hosts = {
    "10.13.41.171" = [ "auth.vk.team" "authcorp.mail.ru" ];
    "10.13.34.186" = [ "confluence.vk.team" ];
  };
}
