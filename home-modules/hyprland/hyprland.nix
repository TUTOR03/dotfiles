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
        
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
        
        bind = [
          "$mod, Q, killactive"
          "$mod, T, exec, kitty"
          "$mod, F, fullscreen"
        ];

        monitor = ",preferred,auto,1";

        general = {
          border_size = 1;
          gaps_in = 0;
          gaps_out = 0;
          gaps_workspaces = 0;
          resize_on_border = true;
          extend_border_grab_area = 10;
          hover_icon_on_border = true;
        };

        decoration = {
          blur = {
            enabled = false;
          };

          shadow = {
            enabled = false;
          };
        };
      };
    };
  };
}