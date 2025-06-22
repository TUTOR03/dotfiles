{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  home.file.".config/waybar/style.css".source = ./style.css;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "0";
        spacing = 0;

        modules-left = [
          "clock"
          "hyprland/workspaces"
          "tray"
        ];
        modules-center = [ ];
        modules-right = [
          "temperature"
          "cpu"
          "memory"
          "bluetooth"
          "network"
          "backlight"
          "pulseaudio"
          "hyprland/language"
          "battery"
          "custom/power"
        ];

        clock = {
          format = "{:%d-%m-%Y %H:%M}";
          interval = 60;
          tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
          show-passive-items = true;
        };

        "hyprland/workspaces" = {
          format = "{name}";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        network = {
          interval = 10;
          family = "ipv4";
          format-wifi = "󰖩 {essid}({signalStrength}%)";
          format-ethernet = " {ipaddr}";
          format-linked = " no-ip";
          format-disconnected = "󰖪";
        };

        bluetooth = {
          format = "󰂯 {status}";
          format-connected = "󰂯 {device_alias}";
          format-off = "󰂲";
        };

        temperature = {
          format = " {temperatureC}°C";
          thermal-zone = 7;
          interval = 10;
          tooltip = false;
        };

        "hyprland/language" = {
          format = "󰌌 {}";
          format-en = "EN";
          format-ru = "RU";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  {volume}%";
          format-icons = {
            default = [ "" "" " " ];
          };
          tooltip = false;
        };

        cpu = {
          interval = 10;
          format = " {usage}%";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = "  {percentage}%";
          tooltip = false;
        };

        battery = {
          interval = 30;
          format = "{icon} {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-icons = [ "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          tooltip = true;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "${config.home.homeDirectory}/.local/bin/powermenu.sh";
        };
      };
    };
  };
}
