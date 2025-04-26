{ config, lib, pkgs, ... }:

{
  options = {
    openvpn.enable = lib.mkEnableOption "enables OpenVPN client with YubiKey support";
    openvpn.servers = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrs;
      default = {};
      description = "OpenVPN server configurations";
    };
  };

  config = lib.mkIf config.openvpn.enable {
    environment.systemPackages = with pkgs; [
      (openvpn.override { pkcs11Support = true; pkcs11helper = pkgs.pkcs11helper; })
      opensc
      yubikey-manager
      yubico-piv-tool
    ];

    security.pam.p11.enable = true;
    services.pcscd.enable = true;
    services.udev.packages = with pkgs; [
      opensc
    ];
    services.openvpn.servers = config.openvpn.servers;
  };
}