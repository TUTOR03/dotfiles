{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./services.nix
    ./networking.nix
  ];

  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };

  programs.amnezia-vpn.enable = true;
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
