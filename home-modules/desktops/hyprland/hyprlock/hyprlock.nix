{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
      };

      background = {
        monitor = "";
        color = "rgb(50, 48, 47)";
      };

      label = [
        # Часы
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(235, 219, 178)";
          font_size = 200;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 232px";
          valign = "center";
          halign = "center";
        }
        # Язык
        {
          monitor = "";
          text = "$LAYOUT[EN,RU]";
          color = "rgb(235, 219, 178)";
          font_size = 24;
          font_family = "JetBrainsMono Nerd Font";
          position = "-16px, -16px";
          valign = "top";
          halign = "right";
        }
      ];

      input-field = {
        monitor = "";
        placeholder_text = "Input Password";
        size = "420, 64";
        outline_thickness = 1;
        dots_size = 0.2;
        dots_spacing = 0.4;
        outer_color = "rgb(102, 92, 84)";
        inner_color = "rgb(80, 73, 69)";
        font_color = "rgb(235, 219, 178)";
        check_color = "rgb(102, 92, 84)";
        fail_color = "rgb(157, 0, 6)";
        fade_on_empty = false;
        valign = "center";
        halign = "center";
      };
    };
  };
}