{ config, lib, ... }:

{
  options = {
    ssh.enable = lib.mkEnableOption "enables ssh";
    ssh.keys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of paths to SSH private keys to be added to ssh-agent";
    };
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
      startAgent = true;
      addKeysToAgent = "yes";
      extraConfig = lib.concatStringsSep "\n" (
        map (key: "IdentityFile ${key}") config.ssh.keys
      );
    };

    home.activation.setupSshKeys = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      chmod 600 ~/.ssh/id_rsa_*
    '';
  };
}