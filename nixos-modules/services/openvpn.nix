{ config, lib, pkgs, ... }:

{
  options = {
    openvpn.enable = lib.mkEnableOption "enables OpenVPN client with YubiKey support";
  };

  config = lib.mkIf config.openvpn.enable {
    environment.systemPackages = with pkgs; [
      (openvpn.override { pkcs11Support = true; pkcs11helper = pkgs.pkcs11helper; })
      opensc
      yubikey-manager
      yubico-piv-tool
    ];

    services.pcscd.enable = true;

    services.udev.packages = with pkgs; [
      opensc
    ];

    security.pam.p11.enable = true;
  };
}