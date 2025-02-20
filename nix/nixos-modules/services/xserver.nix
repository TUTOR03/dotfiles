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

    # Указываем видеодрайвер
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      # Использование проприетарного драйвера
      open = false;

      # Включение поддержки NVIDIA
      modesetting.enable = true;

      # Включение поддержки гибридной графики
      prime = {
        sync.enable = true;
       
        # Inter GPU
        intelBusId = "PCI:0:2:0";
        # NVIDIA GPU
        nvidiaBusId = "PCI:46:0:0";
      };

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Раскладка клавиатуры
    services.xserver.xkb.layout = "us,ru";
    services.xserver.xkb.options = "grp:alt_shift_toggle";
  };
}