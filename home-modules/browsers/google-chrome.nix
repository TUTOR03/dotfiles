{ config, pkgs, lib, ... }:

{
  options = {
    google-chrome.enable = lib.mkEnableOption "enables google-chrome";
  };

  config = lib.mkIf config.google-chrome.enable {
    programs.google-chrome = {
      enable = true;
      commandLineArgs =
      [ 
        "--force-dark-mode"
        "--enable-features=WebUIDarkMode" 
        # "--proxy-server=127.0.0.1:2080" 
      ];
    };
  };
}