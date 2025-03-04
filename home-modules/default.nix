{ ... }:

{
  imports = [
    ./browsers/firefox.nix
    ./browsers/google-chrome.nix
    ./dev/git.nix
    ./dev/ssh.nix
    ./editors/vscode/vscode.nix
  ];
}