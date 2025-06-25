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

  environment.systemPackages = with pkgs; [
    steam
    steamcmd
    steam-tui
    gamemode
    mangohud
    protonup-qt
    heroic
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  powerManagement.enable = true;
}
