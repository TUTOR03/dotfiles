{ config, lib, pkgs, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "enables Thunar file manager";
  };

  config = lib.mkIf config.thunar.enable {
    home.packages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = "thunar.desktop";
    };
  };
}
