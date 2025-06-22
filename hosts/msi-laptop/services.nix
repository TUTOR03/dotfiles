{ ... }:

{
  services = {
    logind.lidSwitch = "suspend";
    libinput.enable = true;
    power-profiles-daemon.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "intel" ];
    };

    displayManager = {
      plasma6.enable = true;
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
      defaultSession = "plasma";
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = false;
    };
  };
}