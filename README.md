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

## Список задач

Отрефакторить модуль git, чтобы имя пользователя и почта передавались в виде параметров

Добавить программы - obs, audacity, nomacs. obs положить как модуль в папку others. Остальные тоже как модули положить в папку media

Отрефакторить home.nix таким образом,чтобы вверху файла были пользовательские настройки, потом шло включение модулей по группам из home-modules. Перед каждой группой нужен комментарий того что это за группа

Вынести neofetch, htop в отдельные модули в папке others

Добавить новые модули для waybar - bluetooth, temperature, language, backlight, pulseaudio

Нужно добавить новую раскалдку клавиатуры и добавить возможность ее переключать

Нужно настроить возможность изменять звук и яркость кнопками

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
