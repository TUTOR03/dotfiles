{ config, lib, pkgs, ... }:

{
  options = {
    hyprland = {
      enable = lib.mkEnableOption "enables Hyprland";
      cursorTheme = lib.mkOption {
        type = lib.types.str;
        default = "Notwaita-Black";
        description = "Cursor theme for Hyprland";
      };
      cursorSize = lib.mkOption {
        type = lib.types.str;
        default = "22";
        description = "Cursor size for Hyprland";
      };
    };
  };

  imports = [
    ./hyprland/general.nix
    ./hyprland/input.nix
    ./hyprland/monitors.nix
    ./hyprland/workspaces.nix
    ./hyprland/keybinds.nix
    ./hyprland/animations.nix
    ./hyprlock/hyprlock.nix
    ./hypridle/hypridle.nix
    ./waybar/waybar.nix
    ./rofi/rofi.nix
  ];

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal-hyprland
      hyprcursor
      fontconfig
      nerdfonts
      gnome-themes-extra
      adwaita-qt
    ];

    fonts.fontconfig.enable = true;

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    home.file.".local/share/icons/${config.hyprland.cursorTheme}".source = ../../../assets/cursors/${config.hyprland.cursorTheme};

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "XCURSOR_THEME,${config.hyprland.cursorTheme}"
          "XCURSOR_SIZE,${config.hyprland.cursorTheme}"
        ];

        exec-once = [
          "xdg-desktop-portal-hyprland"
          "hyprctl setcursor ${config.hyprland.cursorTheme} ${config.hyprland.cursorTheme}"
          "waybar"
          "hypridle"
        ];

        cursor = {
          enable_hyprcursor = true;
          no_warps = true;
        };
      };
    };
  };
}
