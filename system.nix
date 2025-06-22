{ config, lib, hostname, username, useremail, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./hosts/${hostname}/configuration.nix
    ./host-modules
  ];

  system.stateVersion = "25.05";

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

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
    shell = pkgs.bash;
    extraSpecialArgs = {
      inherit hostname username useremail pkgs-unstable;
    };
    users.${ username} = {
      imports = [
        ./hosts/${ hostname}/home.nix
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
