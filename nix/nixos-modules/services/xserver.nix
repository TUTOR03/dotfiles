{ config, pkgs, lib, ... }:

{
  options = {
    xserver.enable = lib.mkEnableOption "enables xserver";
  };

  config = lib.mkIf config.xserver.enable {
    # Включение сервиса
    services.xserver.enable = true;

    # GNOME
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Поддержка тачпада
    services.xserver.libinput.enable = true;

    # Указываем видеодрайвер
    services.xserver.videoDrivers = [ "nvidia" ];

    # Раскладка клавиатуры
    services.xserver.layout = "us,ru";
    services.xserver.xkbOptions = "grp:alt_shift_toggle";
  };
}