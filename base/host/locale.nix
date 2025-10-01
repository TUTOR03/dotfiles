{ config, lib, ... }:

{
  time.timeZone = lib.mkDefault "Europe/Moscow";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  i18n.extraLocaleSettings = lib.mkDefault {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  i18n.supportedLocales = lib.mkDefault [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  console = {
    keyMap = lib.mkDefault "us";
    font = lib.mkDefault "cyr-sun16";
  };

  services.xserver.xkb = {
    layout = lib.mkDefault "us,ru";
    variant = lib.mkDefault "";
    options = lib.mkDefault "grp:alt_shift_toggle";
  };
}
