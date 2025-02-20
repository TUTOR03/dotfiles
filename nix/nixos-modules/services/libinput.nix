{ config, pkgs, lib, ... }:

{
  options = {
    libinput.enable = lib.mkEnableOption "enables libinput";
  };

  config = lib.mkIf config.libinput.enable {
    # Поддержка тачпада
    services.libinput.enable = true;
  };
}