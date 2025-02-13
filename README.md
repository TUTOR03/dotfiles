# Dotfiles

Коллекция всякого, чтобы всегда и везде воссоздать мою систему

## Disko

Файл разметки диска при установке `NixOS`.

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
```
