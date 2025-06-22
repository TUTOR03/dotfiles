{ config, lib, hostName, userName, userEmail, pkgs ... }:

{
  imports = [
    ./hosts/${hostname}/configuration.nix
    ./host-modules
  ];

  system.stateVersion = "25.05";

  networking.hostName = hostname;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit hostName userName userEmail;
    };
    users.${username} = {
      imports = [
        ./hosts/${hostname}/home
        ./home-modules
      ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
