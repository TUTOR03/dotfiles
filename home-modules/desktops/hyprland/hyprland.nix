{ config, lib, pkgs, ... }:

let
  cursorTheme = "Notwaita-Black";
  cursorSize = "22";
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  imports = [
    ./hyprland/general.nix
    ./hyprland/input.nix
    ./hyprland/monitors.nix
    ./hyprland/workspaces.nix
    ./hyprland/keybinds.nix
    ./hyprland/animations.nix
    ./waybar/waybar.nix
    ./rofi/rofi.nix
    ./hyprlock/hyprlock.nix
    ./hypridle.nix
  ];

  config = lib.mkIf config.hyprland.enable {

    home.packages = with pkgs; [
      hyprcursor
    ];

    home.file.".local/share/icons/${cursorTheme}".source = ./cursors/${cursorTheme};

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "XCURSOR_THEME,${cursorTheme}"
          "XCURSOR_SIZE,${cursorSize}"
        ];

        exec-once = [
          "hypridle"
          "waybar"
          "hyprctl setcursor ${cursorTheme} ${cursorSize}"
        ];

        cursor = {
          enable_hyprcursor = true;
          no_warps = true;
        };
      };
    };
  };
}
