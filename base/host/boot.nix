{
  boot.loader = {
    timeout = null;

    systemd-boot = {
      enable = true;
      configurationLimit = 7;
      consoleMode = "max";
    };

    efi.canTouchEfiVariables = true;
  };
}
