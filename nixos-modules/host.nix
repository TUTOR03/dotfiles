{ config, pkgs, lib, ... }:

{
  options = {
    host.hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname to use for host configuration";
    };
    host.username = lib.mkOption {
      type = lib.types.str;
      description = "Username to use for host configuration";
    };
  };

  config = {
    system.stateVersion = "24.11";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = config.host.hostname;
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    users.users.${config.host.username} = {
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
  };
}
