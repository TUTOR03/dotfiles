{ config, lib, pkgs, ... }:

{
  options = {
    vlc.enable = lib.mkEnableOption "enables VLC media player";
  };

  config = lib.mkIf config.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];

    xdg.mimeApps.defaultApplications = {
      "video/mp4" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/avi" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
    };
  };
}
