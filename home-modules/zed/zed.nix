{ config, lib, pkgs, ... }:

{
  options = {
    zed.enable = lib.mkEnableOption "enables Zed Editor";
  };

  config = lib.mkIf config.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];

    home.file.".config/zed/settings.json".source = ./settings.json;
  };
}
