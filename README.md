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
home-manager switch --flake .#sdev@msi-lapto
```
