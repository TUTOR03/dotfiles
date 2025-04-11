{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      waybar
    ];
    
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        exec-once = [
          "waybar"
        ];
        
        bind = [
          "$mod, Q, exec, kitty"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, F, fullscreen"
        ];

        monitor = ",preferred,auto,1";

        general = {
          border_size = 0;
        };
      };
    };
  };
}