{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "ease, 0.4, 0, 0.6, 1"
        "fastEase, 0.05, 0.9, 0.1, 1"
        "linear, 0, 0, 1, 1"
      ];

      animation = [
        "windows, 1, 2, ease, slide"
        "windowsOut, 1, 2, ease, slide"
        "windowsMove, 1, 2, ease, slide"
        "fade, 1, 2, ease"
        "workspaces, 1, 5, fastEase, slide"
      ];
    };
  };
}
