{ config, pkgs, lib, ... }:

let
  community-extensions = with pkgs.vscode-marketplace; [
    # Rust
    rust-lang.rust-analyzer

    # Go
    golang.go

    # Python
    ms-python.python
    ms-python.vscode-pylance
    ms-python.black-formatter
    ms-python.debugpy
    ms-python.isort

    # Svelte
    svelte.svelte-vscode

    # Nix
    bbenoist.nix
    jnoortheen.nix-ide

    # Latex
    james-yu.latex-workshop
    tecosaur.latex-utilities

    # Поддержка форматов файлов
    redhat.vscode-yaml
    tamasfe.even-better-toml
    jock.svg
    shanoor.vscode-nginx
    tomoki1207.pdf
    davidanson.vscode-markdownlint
    yzane.markdown-pdf

    # Утилиты
    dbaeumer.vscode-eslint
    esbenp.prettier-vscode
    ms-azuretools.vscode-docker
    ms-vscode.makefile-tools
    eamodio.gitlens
    mhutchie.git-graph
    adpyke.codesnap
    ms-vscode.hexeditor
    ms-vsliveshare.vsliveshare
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode.remote-explorer
    ms-playwright.playwright
    rangav.vscode-thunder-client
    # continue.continue

    # UI расширения
    pkief.material-icon-theme
    wix.vscode-import-cost
    yoavbls.pretty-ts-errors
    sainnhe.gruvbox-material
  ];

  nixpkgs-extensions = with pkgs.vscode-extensions;[
    vadimcn.vscode-lldb
  ];
in
{
  options = {
    vscode.enable = lib.mkEnableOption "enables VSCode";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default.extensions = community-extensions ++ nixpkgs-extensions;
    };

    home.file.".config/Code/User/settings.json".source = ./settings.json;
    home.file.".config/Code/User/keybindings.json".source = ./keybindings.json;
  };
}
