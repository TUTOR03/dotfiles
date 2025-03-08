{ config, pkgs, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; ${pkgs.hyprland}/bin/Hyprland";
          user = "greeter";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      greetd.gtkgreet
      kitty
    ];
  };
}