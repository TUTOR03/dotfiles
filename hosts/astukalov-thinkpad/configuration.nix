{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nixos-modules
  ];

  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-c237b1e9-8f18-4da1-88e2-96e5d857aac0".device = "/dev/disk/by-uuid/c237b1e9-8f18-4da1-88e2-96e5d857aac0";

  networking.hostName = "astukalov-thinkpad";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  users.users.astukalov = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Поддержка Hyprland
  hyprland = {
    enable = true;
    user = "astukalov";
  };

  vkvpn = {
    enable = true;
    caPath = "${config.users.users.astukalov.home}/secrets/vk-vpn/ca.crt";
    tlsAuthPath = "${config.users.users.astukalov.home}/secrets/vk-vpn/ta.key";
    pkcs11IdFile = "${config.users.users.astukalov.home}/secrets/vk-vpn/pkcs11-id";
  };

  # Поддержка тачпада
  libinput.enable = true;

  # Поддержка режима сна
  powerManagement.enable = true;
  services.logind.lidSwitch = "suspend";
}