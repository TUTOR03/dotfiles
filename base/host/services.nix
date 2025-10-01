{ config, lib, ... }:

{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    printing = {
      enable = true;
      drivers = [ ];
    };

    saned.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    udev.enable = true;

    dbus.enable = true;

    journald.extraConfig = ''
      SystemMaxUse=500M
      MaxRetentionSec=7day
    '';
  };

  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };
}


