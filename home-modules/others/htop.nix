{ config, lib, pkgs, ... }:

{
  options = {
    neofetch.enable = lib.mkEnableOption "enables htop";
  };

  config = lib.mkIf config.neofetch.enable {
    home.packages = with pkgs; [
      htop
    ];
  };
}