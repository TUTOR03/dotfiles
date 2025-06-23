{ ... }:

{
  services = {
    logind.lidSwitch = "suspend";
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "intel" ];
    };

    desktopManager.plasma6.enable = true;
    displayManager = {
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
      alsa.support32Bit = true;
    };
  };

  security.rtkit.enable = true;
}