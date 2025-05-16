{ config, lib, pkgs, ... }:

{
  options = {
    zed.enable = lib.mkEnableOption "enables Zed Editor";
  };

  config = lib.mkIf config.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];

    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "rust"
        "svelte"
        "toml"
        "material-icon-theme"
      ];
      userSettings = {
        theme = "Gruvbox Dark";
        icon_theme = "Material Icon Theme";
        ui_font_size = 16;
        buffer_font_size = 16;
        buffer_font_family = "JetBrainsMono Nerd Font";
      };
    };

  };
}
