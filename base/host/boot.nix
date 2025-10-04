{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = null;
      systemd-boot = {
        enable = true;
        configurationLimit = 7;
      };
    };
  };
}
