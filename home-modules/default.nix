{ ... }:

{
  imports = [
    # Browsers
    ./browsers/firefox.nix
    ./browsers/google-chrome.nix
    # Code-editors
    ./code-editors/vscode/vscode.nix
    # Langs
    ./langs/nodejs.nix
    ./langs/rust.nix
    # Media
    ./media/vlc.nix
    # Games
    ./games/steam.nix
    # Desktops
    ./desktops/hyprland/hyprland.nix
    ./others/git.nix
    ./others/ssh.nix
  ];
}