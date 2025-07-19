{ userName, ... }:

{
  services = {
    power-profiles-daemon.enable = true;
    printing.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
      };
      videoDrivers = [ "nvidia" "amdgpu" ];
    };

    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        settings = {
          Autologin = {
            Session = "plasma.desktop";
            User = userName;
          };
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
