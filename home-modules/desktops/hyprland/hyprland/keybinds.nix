{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    grim
    slurp
    swappy
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    # Бинды для мыши
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # Бинды для клавиатуры
    bind = [
      # Всякое
      "$mod, Q, killactive"
      "$mod, F, fullscreen"
      "$mod, T, exec, kitty"
      "$mod, V, togglefloating"
      "$mod, R, exec, rofi -show drun"
      "$mod, L, exec, hyprlock"
      
      # Перемещение фокуса между окнами
      "$mod, left, movefocus, l"
      "$mod, down, movefocus, d"
      "$mod, up, movefocus, u"
      "$mod, right, movefocus, r"

      # Быстроке переключение на вокрспейс
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Переместить активное окно на воркспейс
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Переместиться на след/пред вокрспейс
      "$mod, page_up, workspace, -1"
      "$mod, page_down, workspace, +1"

      # Управлению яркостью экрана
      ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"

      # Управлению уровнем громкости
      ",XF86AudioRaiseVolume, exec, pamixer --increase 5"
      ",XF86AudioLowerVolume, exec, pamixer --decrease 5"
      ",XF86AudioMute, exec, pamixer --toggle-mute"

      # Скриншоты
      ",Print, exec, grim - | wl-copy && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
      "SHIFT,Print, exec, grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
      "CTRL,Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
    ];
  };
}