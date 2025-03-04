{ config, lib, ... }:

{
  options = {
    ssh.enable = lib.mkEnableOption "enables ssh";
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
    };

    home.activation.setupSshKeys = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      chmod 600 ~/.ssh/id_rsa_*
    '';
  };
}