{ config, pkgs, lib, ... }:

{
  options = {
    arkenfox.enable = lib.mkEnableOption "enables firefox with arkenfox profiles";
  };

  config = lib.mkIf config.arkenfox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFeedbackCommands = true;
        DisableCrashReporter = true;
        DisableProfileImport = true;
        AppAutoUpdate = false;
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableAccounts = true;
        PasswordManagerEnabled = false;
        OfferToSaveLogins = false;
        AutofillCreditCardEnabled = false;
        SearchSuggestEnabled = false;
        SuggestBookmarks = false;
        SuggestHistory = false;
        DisablePush = true;
        CaptivePortal = false;
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://dns.quad9.net/dns-query";
          Locked = true;
        };
      };

      arkenfox = {
        enable = true;
        version = "140.0";
      };

      profiles = {
        Default = {
          id = 0;
          name = "Default";
          isDefault = true;

          search = {
            force = true;
            default = "ddg";
            privateDefault = "ddg";
          };

          arkenfox = {
            enable = true;

            "0000".enable = true;
            "0100" = {
              enable = true;
              "0102"."browser.startup.page".value = 3;
              "0103"."browser.startup.homepage".value = "about:blank";
            };
            "0200".enable = true;
            "0300".enable = true;
            "0400".enable = true;
            "0600".enable = true;
            "0700".enable = true;
            "0800".enable = true;
            "0900".enable = true;
            "1000".enable = true;
            "1200".enable = true;
            "1600".enable = true;
            "1700".enable = true;
            "2400".enable = true;
            "2600".enable = true;
            "2700".enable = true;
            "5000".enable = true;
            "8500".enable = true;
            "9000".enable = true;
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            skip-redirect
            user-agent-string-switcher
            bitwarden
          ];

          bookmarks = {
            force = true;
            settings = [
              {
                toolbar = true;
                bookmarks = [
                  {
                    name = "TG";
                    url = "https://web.telegram.org/k";
                  }
                  {
                    name = "Max";
                    url = "https://web.max.ru";
                  }
                  {
                    name = "VKTeams";
                    url = "https://myteam.mail.ru/webim";
                  }
                  {
                    name = "Max work";
                    bookmarks = [
                      {
                        name = "Gitlab";
                        url = "https://gitlab.corp.mail.ru/oneme/web/oneweb";
                      }
                      {
                        name = "Tracer";
                        url = "https://apptracer.ru/4079569/crashes/date=LAST_24H";
                      }
                      {
                        name = "Задачи";
                        url = "https://jira.vk.team/secure/RapidBoard.jspa?rapidView=10940";
                      }
                      {
                        name = "API Doc";
                        url = "https://confluence.vk.team/pages/viewpage.action?pageId=1248630784";
                      }
                      {
                        name = "Grafana";
                        url = "https://goc.vk.team/?orgId=1&viewPanel=3";
                      }
                      {
                        name = "DataLens";
                        url = "https://datalens.vk.team/collections/kif9n195kixa7";
                      }
                    ];
                  }
                  {
                    name = "VPN";
                    bookmarks = [
                      {
                        name = "FI-VPN";
                        url = "https://vpnpanel.stdev.space:31811/zXHpPk07aRW7LXx/panel";
                      }
                    ];
                  }
                  {
                    name = "Почта";
                    bookmarks = [
                      {
                        name = "Proton";
                        url = "https://proton.me";
                      }
                      {
                        name = "Yandex";
                        url = "https://mail.yandex.ru";
                      }
                      {
                        name = "Google";
                        url = "https://mail.google.com";
                      }
                    ];
                  }
                ];
              }
            ];
          };
        };
      };
    };

    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/ftp" = [ "firefox.desktop" ];
        "application/pdf" = [ "firefox.desktop" ];
      };
    };
  };
}
