{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = config.hyprland.monitors;
  };
}
