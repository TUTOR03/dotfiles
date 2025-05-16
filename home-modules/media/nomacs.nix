{ config, lib, pkgs, ... }:

{
  options = {
    nomacs.enable = lib.mkEnableOption "enables Nomacs";
  };

  config = lib.mkIf config.nomacs.enable {
    home.packages = with pkgs; [
      nomacs
    ];
  };
}
