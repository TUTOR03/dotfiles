{ config, inputs, hostname, username, pkgs, pkgs-unstable, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./home-modules
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      [[ -r "${pkgs.bash-completion}/share/bash-completion/bash_completion" ]] && source "${pkgs.bash-completion}/share/bash-completion/bash_completion"

      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }

      PS1='\[\033[38;5;245m\]\A \[\033[38;5;110m\]\u \[\033[38;5;108m\]~/$(basename "$(dirname "$PWD")")/$(basename "$PWD")\[\033[38;5;180m\]$(parse_git_branch)\[\033[38;5;245m\]$\[\033[0m\] '

      if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
      fi
    '';
    shellAliases = {
      cls = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#${hostname}";
      rebuild-home = "home-manager switch --flake ${config.home.homeDirectory}/dotfiles#${username}@${hostname}";
    };
  };

  # Рабочий стол - Hyprland
  hyprland = {
    enable = true;
    monitors = [
      "eDP-1, 2880x1800@90, 0x0, 1.5"
      "DP-3, 3840x2160@60, -320x-1440, 1.5"
      "HDMI-A-1, 1920x1080@60, 0x-1080,1"
      ",preferred,auto,1"
    ];
  };

  # Пакеты, которые не тербуют доп конфигурации
  home.packages = with pkgs; [
    # Терсинал
    ghostty
    bash-completion
    # Сеть
    dig
    dnsutils
    networkmanagerapplet
    # Bluetooth
    blueman
    # Заметки
    obsidian
    # Медиа
    nomacs
    audacity
    # Браузеры
    firefox
    # Другое
    texlive.combined.scheme-full
    nixpkgs-fmt
    obs-studio
    neofetch
    htop
  ];

  # SSH и Git
  ssh = {
    enable = true;
    keys = [ "~/.ssh/id_rsa_thinkpad_github" "~/.ssh/id_rsa_thinkpad_vk_gitlab" ];
  };
  programs.ssh = {
    extraConfig = ''
      AddressFamily inet
    '';
  };
  git = {
    enable = true;
    userName = "TUTOR03";
    userEmail = "stukalov.dev@gmail.com";
  };

  # Браузеры
  google-chrome.enable = true;

  # Редакторы кода
  vscode.enable = true;
  zed.enable = true;

  # Языки
  nodejs = {
    enable = true;
    versions = with pkgs; [ nodejs_20 ];
  };
  rust.enable = true;

  # Прочее
  thunar.enable = true;
  vlc.enable = true;
  printers.enable = true;

  sops.enable = true;
  vkvpn = {
    enable = true;
    caPath = config.sops.secrets."ca.crt".path;
    tlsAuthPath = config.sops.secrets."ta.key".path;
    pkcs11IdPath = config.sops.secrets.pkcs11-id.path;
  };
}
