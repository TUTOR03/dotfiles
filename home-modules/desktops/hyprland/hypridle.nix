{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hypridle
  ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Приглушаем яркость после 2 минут 
        {
          timeout = 120;
          on-timeout = "brightnessctl -s set 10%";
          on-resume = "brightnessctl -r";
        }
        # Запускаем экрна блокировки после 2.5 минут
        {
          timeout = 150;
          on-timeout = "pidof hyprlock || hyprlock";
        }
        # Отключаем экран и включаем экономию батареи после 3 минут
        {
          timeout = 180;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        # Переходим в режим сна после 10 минут
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
