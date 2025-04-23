# Dotfiles

Коллекция всякого, чтобы всегда и везде воссоздать мою систему

## Disko

Файл разметки диска при установке `NixOS`.

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
```

```bash
sudo nixos-rebuild switch --flake .#msi-laptop
```

```bash
home-manager switch --flake .#sdev@msi-laptop
```

## Что мы хотим видеть

browsers:

- firefox(done)
- google-chrome(done)

code-editors:

- vscode(done)

langs:

- nodejs(done)
- rust(done)
- go

media:

- vlc(done)
- nomacs
- audacity

desktops:

- hyprland(done)
- waybar
- rofi

vpn:

- wireguard
- vless client
- openvpn

other:

- git(done)
- ssh(done)
- obs
- screenshot tool
- file manager
