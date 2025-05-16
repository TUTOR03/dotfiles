{ config, lib, pkgs, ... }:

{
  options = {
    vlc.enable = lib.mkEnableOption "enables VLC media player";
  };

  config = lib.mkIf config.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
