{ ... }:

{
  imports = [
    # Браузеры
    ./browsers/google-chrome.nix
    # Редакторы кода
    ./code-editors/vscode/vscode.nix
    ./code-editors/zed/zed.nix
    # Языки
    ./langs/nodejs.nix
    ./langs/rust.nix
    # Игры
    ./games/steam.nix
    # Десктопы
    ./desktops/hyprland/hyprland.nix
    # Другое
    ./other/git.nix
    ./other/ssh.nix
    ./other/vlc.nix
    ./other/thunar.nix
    ./other/printers.nix
  ];
}
