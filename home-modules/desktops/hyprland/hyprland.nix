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
      brightnessctl
      pamixer
    ];

    home.file.".local/share/icons/${cursorTheme}".source = ./cursors/${cursorTheme};
    
    # Hyprland
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

        cursor = {
          enable_hyprcursor = true;
          no_warps = true;
        };

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";
        };
        
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
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ",XF86AudioRaiseVolume, exec, pamixer --increase 5"
          ",XF86AudioLowerVolume, exec, pamixer --decrease 5"
          ",XF86AudioMute, exec, pamixer --toggle-mute"
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
          "col.inactive_border"="rgb(f8f8f2)";
          "col.active_border"="rgb(a6e22e)";
          resize_on_border = false;
          extend_border_grab_area = 10;
          hover_icon_on_border = false;
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
      };
    };

    # Waybar
    home.file.".config/waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink ./waybar/config.jsonc;
    home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink ./waybar/style.css ;

    programs.waybar = {
      enable = true;
    };

    # Rofi
    home.file.".config/rofi/theme.rasi".source = config.lib.file.mkOutOfStoreSymlink ./rofi/theme.rasi;

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun";
        font = "JetBrainsMono Nerd Font SemiBold 14";
        show-icons = true;
        icon-theme = "Papirus";
        display-drun = "App";
        drun-display-format = "{icon} {name}";
        disable-history = false;
        sidebar-mode = false;
      };
      theme = "theme";
    };
  };
}