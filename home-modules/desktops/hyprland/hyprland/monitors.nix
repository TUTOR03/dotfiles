{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # Основной монитор
      "eDP-1, 2880x1800@90, 0x0, 1.5"
      "DP-3, 3840x2160@60, -320x-1440, 1.5"
      # Для неизвестных мониторов
      ",preferred,auto,1"
    ];
  };
}