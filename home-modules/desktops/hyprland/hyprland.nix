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
      hyprlock
      rofi-wayland
      brightnessctl
      pamixer
      grim
      slurp
      swappy
      wl-clipboard
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
          "$mod, L, exec, hyprlock"
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ",XF86AudioRaiseVolume, exec, pamixer --increase 5"
          ",XF86AudioLowerVolume, exec, pamixer --decrease 5"
          ",XF86AudioMute, exec, pamixer --toggle-mute"
          ",Print, exec, grim - | wl-copy && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
          "SHIFT,Print, exec, grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
          "CTRL,Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        ];

        workspace = [
          "1, monitor:eDP-1"
          "2, monitor:eDP-1"
          "3, monitor:eDP-1"
          "4, monitor:DP-3"
        ];

        monitor = [
          "eDP-1, 2880x1800@90, 0x0, 1.5"
          "DP-3, 3840x2160@60, -320x-1440, 1.5"
        ];

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
        display-drun = "";
        drun-display-format = "{icon} {name}";
        disable-history = false;
        sidebar-mode = false;
      };
      theme = "theme";
    };

    programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        color = "rgb(28, 37, 38)";
      };

      label = {
        monitor = "";
        text = "$TIME";
        color = "rgb(255, 255, 255)";
        font_size = 50;
        font_family = "Sans";
        position = "0, 50";
        halign = "center";
        valign = "center";
      };

      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.3;
        outer_color = "rgb(255, 255, 255)";
        inner_color = "rgb(28, 37, 38)";
        font_color = "rgb(255, 255, 255)";
        fade_on_empty = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };
  };
}