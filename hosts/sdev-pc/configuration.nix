{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./services.nix
    ./networking.nix
  ];

  environment.systemPackages = with pkgs; [
    gamemode
    mangohud
    protonup-qt
  ];

  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };

  programs.coolercontrol.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  powerManagement.enable = true;

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      plasma6Support = true;
      waylandFrontend = true;
      addons = with pkgs; [
        kdePackages.fcitx5-qt
        fcitx5-mozc
      ];
      settings = {
        addons = {
          wayland = {
            globalSection = {
              "Allow Overriding System XKB Settings" = "False";
            };
          };

          xcb = {
            globalSection = {
              "Allow Overriding System XKB Settings" = "False";
              AlwaysSetToGroupLayout = "False";
            };
          };
        };
      };
    };
  };
}
