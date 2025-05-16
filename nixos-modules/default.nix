{ ... }:

{
  imports = [
    ./services/libinput.nix
    ./services/xserver.nix
    ./services/openvpn.nix
    ./hyprland.nix
  ];
}
