{ config, pkgs, hostName, ... }:
{
  sops = {
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    defaultSopsFile = ../../../secrets/${hostName}.yaml;
    secrets = {
      "ssh/github/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_github";
        mode = "0600";
      };
      "ssh/github/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_github.pub";
        mode = "0644";
      };
      "ssh/fi-vpn/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_fi_vpn";
        mode = "0600";
      };
      "ssh/fi-vpn/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_fi_vpn.pub";
        mode = "0644";
      };
    };
  };
}
