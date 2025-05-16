{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  home.file.".config/rofi/base.rasi".source = ./base.rasi;
  home.file.".config/rofi/launcher.rasi".source = ./launcher.rasi;
  home.file.".config/rofi/powermenu.rasi".source = ./powermenu.rasi;
  home.file.".local/bin/powermenu.sh" = {
    source = ./powermenu.sh;
    executable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      # General
      modi = "drun";
      case-sensitive = false;
      cycle = true;
      show-icons = true;
      icon-theme = "Papirus";
      normalize-match = true;

      # Matching
      matching = "normal";
      tokenize = true;

      # Drun
      display-drun = "";
      drun-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{icon} {name}";

      # Misc
      font = "JetBrainsMono Nerd Font SemiBold 14";
      click-to-exit = true;
    };
    theme = "launcher";
  };
}
