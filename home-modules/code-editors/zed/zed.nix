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
      ];
      userSettings = {
        theme = "Gruvbox Dark";
        ui_font_size = 16;
        buffer_font_size = 16;
        buffer_font_family = "JetBrainsMono Nerd Font";
      };
    };

  };
}