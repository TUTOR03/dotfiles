{ config, pkgs, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
    hyprland.username = lib.mkOption {
      type = lib.types.str;
      description = "Username to automatically log in and start Hyprland for";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = config.hyprland.username;
        };
      };
    };
  };
}
