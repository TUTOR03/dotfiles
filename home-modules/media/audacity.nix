{ config, lib, pkgs, ... }:

{
  options = {
    audacity.enable = lib.mkEnableOption "enables Audacity";
  };

  config = lib.mkIf config.audacity.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
