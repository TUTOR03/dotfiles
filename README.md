# Dotfiles

Конфигурация nix-os под разные хосты

## Disko

Чтобы установить систему, используя disko файл:

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount <disko file path>

sudo nixos-generate-config --root /mnt

sudo nixos-install --flake .#<hostname>
```

## Rebuild

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```
