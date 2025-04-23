{ config, lib, pkgs, ... }:

{
  options = {
    htop.enable = lib.mkEnableOption "enables htop";
  };

  config = lib.mkIf config.htop.enable {
    home.packages = with pkgs; [
      htop
    ];
  };
}