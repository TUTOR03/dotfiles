{ config, lib, pkgs, ... }:

{
  options = {
    sops.enable = lib.mkEnableOption "enables sops for secret management in Home Manager";
  };

  config = lib.mkIf config.sops.enable {
    home.packages = with pkgs; [ sops ];

    sops = {
      defaultSopsFile = ../../../secrets/astukalov-thinkpad/vkvpn.yaml;
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      secrets = {
        "ca.crt" = {
          path = "${config.home.homeDirectory}/.secrets/vk-vpn/ca.crt";
        };
        "ta.key" = {
          path = "${config.home.homeDirectory}/.secrets/vk-vpn/ta.key";
        };
        "pkcs11-id" = {
          path = "${config.home.homeDirectory}/.secrets/vk-vpn/pkcs11-id";
        };
      };
    };
  };
}
