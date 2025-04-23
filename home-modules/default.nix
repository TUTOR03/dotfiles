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
    ./media/audacity.nix
    ./media/nomacs.nix
    # Games
    ./games/steam.nix
    # Desktops
    ./desktops/hyprland/hyprland.nix
    # Others
    ./others/git.nix
    ./others/ssh.nix
    ./others/obs.nix
    ./others/htop.nix
    ./others/neofetch.nix
  ];
}