{ config, lib, pkgs, ... }:
{
  options = {
    desktops.kde = {
      enable = lib.mkEnableOption "Enables KDE Plasma user configuration";

      theme = lib.mkOption {
        type = lib.types.str;
        default = "breeze-dark";
        description = "KDE theme name";
      };

      iconTheme = lib.mkOption {
        type = lib.types.str;
        default = "breeze-dark";
        description = "Icon theme name";
      };

      cursorTheme = lib.mkOption {
        type = lib.types.str;
        default = "breeze_cursors";
        description = "Cursor theme name";
      };
    };
  };

  config = lib.mkIf config.desktops.kde.enable {
    home.packages = with pkgs; [
      kdePackages.breeze
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
    ];

    programs.plasma = {
      enable = true;

      shortcuts = lib.mkDefault { };

      workspace = {
        lookAndFeel = lib.mkDefault config.desktops.kde.theme;
        cursor.theme = lib.mkDefault config.desktops.kde.cursorTheme;
        iconTheme = lib.mkDefault config.desktops.kde.iconTheme;
      };

      panels = lib.mkDefault [
        {
          location = "bottom";
          alignment = "center";
          height = 44;
          floating = false;
          hiding = "normalpanel";
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config.General.icon = "nix-snowflake";
            }
            { name = "org.kde.plasma.pager"; }
            { name = "org.kde.plasma.icontasks"; }
            { name = "org.kde.plasma.systemtray"; }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
                date.enable = true;
              };
            }
          ];
        }
      ];


      kwin = {
        virtualDesktops = lib.mkDefault {
          number = 4;
          rows = 1;
        };
        edgeBarrier = lib.mkDefault 0;
        effects = lib.mkDefault {
          shakeCursor.enable = false;
          blur.enable = false;
          desktopSwitching.animation = "slide";
        };
      };

      configFile = {
        "dolphinrc"."General"."ShowFullPath" = lib.mkDefault true;
        "dolphinrc"."General"."RememberOpenedTabs" = lib.mkDefault false;
        "konsolerc"."TabBar"."TabBarPosition" = lib.mkDefault "Top";
      };
    };

    gtk = {
      enable = true;
      theme = lib.mkDefault {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = lib.mkDefault {
        name = config.desktops.kde.iconTheme;
        package = pkgs.kdePackages.breeze-icons;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = lib.mkDefault "kde";
      style = lib.mkDefault {
        name = "breeze";
        package = pkgs.kdePackages.breeze;
      };
    };
  };
}
