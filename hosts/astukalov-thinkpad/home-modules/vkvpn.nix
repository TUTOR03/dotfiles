{ config, lib, pkgs, ... }:

{
  options = {
    vkvpn.enable = lib.mkEnableOption "enables VKVPN with OpenVPN";
    vkvpn.caPath = lib.mkOption {
      type = lib.types.path;
      description = "Path to CA certificate file";
    };
    vkvpn.tlsAuthPath = lib.mkOption {
      type = lib.types.path;
      description = "Path to TLS auth key file";
    };
    vkvpn.pkcs11IdFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to file containing pkcs11-id for OpenVPN authentication";
    };
  };

  config = lib.mkIf config.vkvpn.enable {

    home.file.".openvpn/vkvpn/config.conf".text = ''
      remote barbosubi.corp.mail.ru 443 tcp-client
      nobind
      dev tun
      persist-tun
      persist-key
      pull
      tls-client
      ca ${config.vkvpn.caPath}
      pkcs11-id '${builtins.readFile config.vkvpn.pkcs11IdFile}'
      pkcs11-providers ${pkgs.opensc}/lib/opensc-pkcs11.so
      remote-cert-tls server
      route remote_host default net_gateway
      tls-auth ${config.vkvpn.tlsAuthPath} 1
      keepalive 10 60
      reneg-sec 0
    '';

    programs.bash.shellAliases = {
      vk-vpn = "sudo ${pkgs.openvpn}/bin/openvpn --config ${config.home.homeDirectory}/.openvpn/vkvpn/config.conf";
    };
  };
}
