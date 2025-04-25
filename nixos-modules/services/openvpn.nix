{ config, lib, pkgs, ... }:

{
  options = {
    openvpn.enable = lib.mkEnableOption "enables OpenVPN client with YubiKey support";
  };

  config = lib.mkIf config.openvpn.enable {
    environment.systemPackages = with pkgs; [
      openvpn
      opensc
      yubikey-manager
    ];

    services.pcscd.enable = true;

    services.udev.packages = with pkgs; [
      opensc
    ];

    security.pam.pkcs11 = {
      enable = true;
      module = "${pkgs.opensc}/lib/opensc-pkcs11.so";
    };
  };
}