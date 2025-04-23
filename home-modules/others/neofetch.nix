{ config, lib, pkgs, ... }:

{
  options = {
    neofetch.enable = lib.mkEnableOption "enables Neofetch";
  };

  config = lib.mkIf config.neofetch.enable {
    home.packages = with pkgs; [
      neofetch
    ];
  };
}