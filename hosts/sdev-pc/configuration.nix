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
    linux-firmware
  ];

  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };
  programs.amnezia-vpn.enable = true;

  programs.coolercontrol.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  powerManagement.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
}
