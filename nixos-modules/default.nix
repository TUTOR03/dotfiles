{ ... }:

{
  imports = [
    ./services/libinput.nix
    ./services/xserver.nix
    ./hyprland.nix
  ];
}