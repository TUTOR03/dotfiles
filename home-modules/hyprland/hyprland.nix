{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        
        bind = [
          "$mod, Q, exec, kitty"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, F, fullscreen"
        ];
        monitor = ",preferred,auto,1";
      };
    };

    home.packages = with pkgs; [
      waybar
    ];
  };
}