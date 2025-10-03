{
  boot.loader = {
    timeout = null;
    plymouth.enable = true;

    systemd-boot = {
      enable = true;
      configurationLimit = 7;
    };

    efi.canTouchEfiVariables = true;
  };
}
