{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-partlabel/luks"; # Поддержка LUKS
  boot.resumeDevice = "/dev/mapper/crypted-swap"; # Для режима сна
  boot.kernelParams = [ "resume_offset=123456" ]; # Заменить на актуальный offset для swap

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

  # Поддержка тачпада
  libinput.enable = true;

  # Поддержка режима сна
  powerManagement.enable = true;
  services.logind.lidSwitch = "suspend";
}