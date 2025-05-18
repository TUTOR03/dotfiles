{ config, pkgs, lib, ... }:

{
  options = {
    google-chrome.enable = lib.mkEnableOption "enables google-chrome";
  };

  config = lib.mkIf config.google-chrome.enable {
    programs.google-chrome = {
      enable = true;
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "text/html" = "google-chrome.desktop";
      "application/xhtml+xml" = "google-chrome.desktop";
    };
  };
}
