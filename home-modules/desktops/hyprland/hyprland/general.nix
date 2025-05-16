{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 1;
      gaps_in = 4;
      gaps_out = 4;
      gaps_workspaces = 0;
      "col.inactive_border" = "rgb(32302F)";
      "col.active_border" = "rgb(665C54)";
      layout = "dwindle";
      allow_tearing = false;
    };

    decoration = {
      rounding = 8;
      blur.enabled = false;
      shadow.enabled = false;
    };

    dwindle = {
      preserve_split = true;
    };

    misc = {
      disable_hyprland_logo = true;
    };
  };
}
