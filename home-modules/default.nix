{ ... }:

{
  imports = [
    ./vscode/vscode.nix
    ./zed/zed.nix
    ./nodejs.nix
    ./rust.nix
    ./hyprland/hyprland.nix
    ./git.nix
    ./ssh.nix
    ./vlc.nix
  ];
}
