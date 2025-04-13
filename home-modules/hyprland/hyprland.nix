{ config, lib, pkgs, ... }:


let
  cursorTheme = "Notwaita-Black";
  cursorSize = "22";
in {
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      waybar
      hyprcursor
      rofi-wayland
    ];

    home.file.".local/share/icons/${cursorTheme}".source = ./cursors/${cursorTheme};
    
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        env = [
          "XCURSOR_THEME,${cursorTheme}"
          "XCURSOR_SIZE,${cursorSize}"
        ];

        exec-once = [
          "waybar"
          "hyprctl setcursor ${cursorTheme} ${cursorSize}"
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
          "$mod, R, exec, rofi -show drun"
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
          gaps_in = 4;
          gaps_out = 0;
          gaps_workspaces = 0;
          resize_on_border = true;
          extend_border_grab_area = 10;
          hover_icon_on_border = true;
        };

        decoration = {
          rounding = 10;
          rounding_power = 2.0;

          blur = {
            enabled = false;
          };

          shadow = {
            enabled = false;
          };
        };

        cursor = {
          enable_hyprcursor = true;
        };
      };
    };

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "Monokai";
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          margin = "8 0 8 0";
          spacing = "8";

          modules-left = [ "clock" "tray"];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [ "cpu" "memory" "network" "battery" ];

          clock = {
            format = "{:%d-%m-%Y %H:%M}";
            interval = 60;
          };

          tray = {
            icon-size =  16;
            spacing = 4;
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              default = "";
              empty = "";
            };
            persistent-workspaces = {
              "*" = 3;
            };
          };

          cpu = {
            interval = 30;
            format = "{usage}%";
            tooltip = true;
          };

          memory = {
            interval = 30;
            format = "{percentage}%";
            tooltip = true;
          };

          network = {
            interval = 30;
            format-wifi = "{essid} ({signalStrength}%)󰖩";
            format-ethernet = "{ipaddr}/{cidr}󰌗";
            format-disconnected = "󰖪";
          };

          battery = {
            interval = 30;
            format = "{capacity}%{icon}";
            format-charging = "{capacity}%󰂄";
            format-plugged = "{capacity}%";
            format-icons = [ "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          };
        };
      };

      style = ''
        * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 16px;
        }

        window#waybar{
          all:unset;
          color: #F8F8F2;
        }

        .modules-left {
          padding: 8px;
          border-radius: 10px;
          background: #3E3D32;
        }

        .modules-center {
          padding: 8px;
          border-radius: 10px;
          background: #3E3D32;
        }

        .modules-right {
          padding: 8px;
          border-radius: 10px;
          background: #3E3D32;
        }

        tooltip {
          background: #3E3D32;
          color: #F8F8F2;
        }

        #clock {}

        #workspaces button {
          margin: 0 2px;
        }

        #workspaces button:hover {
          color: #878B91;
        }

        #workspaces button.active {
          color: #A6E22E;
        }
      '';
    };
  };
}