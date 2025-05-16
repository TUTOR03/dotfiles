{ config, lib, pkgs, ... }:

{
  options = {
    obs.enable = lib.mkEnableOption "enables OBS Studio";
  };

  config = lib.mkIf config.obs.enable {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
