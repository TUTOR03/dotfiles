{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      waybar
      hyprcursor
    ];
    
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        exec-once = [
          "waybar"
          "hyprcursor"
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
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod ALT, left, workspace, -1"
          "$mod ALT, right, workspace, +1"
          "$mod, left, movefocus, l"
          "$mod, down, movefocus, d"
          "$mod, up, movefocus, u"
          "$mod, right, movefocus, r"
        ];

        workspace = [
          "1, default:true"
          "2, default:true"
          "3, default:true"
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

        cursor = {
          enable_hyprcursor = true;
          default = "default";
        };
      };
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [ "cpu" "memory" "battery" "tray" ];
          "hyprland/workspaces" = {
            format = "{name}";
            on-click = "activate";
            persistent-workspaces = {
              "*" = 3;
            };
          };
          clock = {
            format = "{:%d-%m-%Y %H:%M}";
          };
          cpu = {
            format = "CPU {usage}%";
          };
          memory = {
            format = "Mem {}%";
          };
          battery = {
            format = "{capacity}% {icon}";
            format-icons = [ "🔋" "🔌" ];
          };
        };
      };
      style = ''
        * {
          font-family: JetBrains Mono;
          font-size: 13px;
        }
        #workspaces button {
          padding: 0 5px;
          color: #ffffff;
        }
        #workspaces button.active {
          background: #646464;
        }
        #clock, #cpu, #memory, #battery, #tray {
          padding: 0 10px;
        }
      '';
    };
  };
}