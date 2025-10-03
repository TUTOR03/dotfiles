# Руководство по установке NixOS

## Обзор

Данное руководство содержит инструкции по развертыванию модульной конфигурации NixOS с поддержкой Home Manager на различных хостах с использованием Flakes и Disko для автоматической разметки дисков.

## Требования

- Установочный ISO образ NixOS (минимальный или графический)
- Целевая машина с поддержкой UEFI
- Подключение к сети
- USB-накопитель (для загрузочного носителя)

## Процедура установки

### 1. Подготовка загрузочного носителя

1. Загрузите ISO-образ NixOS с сайта [nixos.org](https://nixos.org/download)
2. Создайте загрузочный USB-накопитель, следуя инструкциям в [NixOS Manual - Booting from USB](https://nixos.org/manual/nixos/stable/#sec-booting-from-usb-linux)

**Linux:**

```bash
sudo dd bs=4M conv=fsync oflag=direct status=progress if=<path-to-image> of=/dev/sdX
```

**Windows/macOS:** Используйте утилиты Rufus, Etcher или аналогичные.

### 2. Загрузка в Live-окружение

1. Вставьте USB-накопитель и загрузитесь с него
2. Настройте сетевое подключение, если оно не установлено автоматически

### 3. Клонирование репозитория конфигурации

```bash
# Установите git, если он недоступен
nix-shell -p git

# Клонируйте репозиторий с конфигурацией
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
```

### 4. Разметка диска с помощью Disko

Disko автоматизирует процесс разметки и форматирования дисков. Каждая конфигурация хоста должна иметь соответствующий файл `disko.nix` в директории `./hosts/<hostName>/`.

**Стандартная установка:**

```bash
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  ./hosts/<hostName>/disko.nix
```

**⚠️ Предупреждение:** Данная команда уничтожит все существующие данные на целевом диске.

#### Конфигурация для двойной загрузки (Windows)

Для установки в режиме двойной загрузки с Windows 11 необходимо зарезервировать место во время разметки Disko:

```nix
# В файле ./hosts/<hostName>/disko.nix
windows = {
  size = "150G";
  type = "0700";  # Раздел базовых данных Microsoft
};
```

**Порядок установки:**

1. Запустите Disko для создания разметки разделов
2. Завершите установку NixOS
3. Установите Windows в зарезервированный раздел
4. При необходимости восстановите GRUB/systemd-boot

### 5. Установка NixOS

После завершения работы Disko система будет смонтирована в `/mnt`.

Если вы не знаете какие модули вам нужны для `boot.initrd` или `boot.kernelModules`, сначала лучше сгенерировать стандартный конфиг и скопировать оттуда.

```bash
# Генерация конфигурации оборудования
sudo nixos-generate-config --root /mnt

```

Далее просто устанавливаем nixos через команду.

```bash
# Установка NixOS с использованием flake-конфигурации
sudo nixos-install --flake .#<hostName>
```

Значение `<hostName>` должно совпадать с одной из конфигураций, определенных в вашем `flake.nix`.

**После установки:**

```bash
# Перезагрузка в новую систему
reboot
```

### 6. Настройка Home Manager

После загрузки в установленную систему необходимо настроить пользовательское окружение с помощью Home Manager.

**Первоначальная настройка (от имени root):**

```bash
# Установите пароль для учетной записи пользователя
passwd <userName>

# Переключитесь на учетную запись пользователя
su - <userName>
```

**Развертывание конфигурации Home Manager:**

```bash
cd /path/to/your/dotfiles

# Первоначальная активация Home Manager
nix run home-manager/release-25.05 -- switch \
  --flake .#<userName>@<hostName>
```

Для последующих обновлений используйте предоставленные алиасы (см. ниже).

## Управление системой

### Пересборка системы

**Системная конфигурация NixOS:**

```bash
# Полная команда
sudo nixos-rebuild switch --flake .#<hostName>

# Использование алиаса
rebuild
```

**Конфигурация Home Manager:**

```bash
# Полная команда
home-manager switch --flake .#<userName>@<hostName>

# Использование алиаса
rebuild-home
```

### Обновление системы

```bash
# Обновление flake inputs
nix flake update

# Пересборка с обновленными зависимостями
sudo nixos-rebuild switch --flake .#<hostName>
home-manager switch --flake .#<userName>@<hostName>
```

### Сборка мусора

**Удаление неиспользуемых путей хранилища:**

```bash
# Системный уровень NixOS
sudo nix-collect-garbage -d

# Home Manager (уровень пользователя)
nix-collect-garbage -d
```

**Очистка старых поколений:**

```bash
# Удаление поколений NixOS старше 7 дней
sudo nix-collect-garbage --delete-older-than 7d

# Удаление поколений Home Manager старше 7 дней
home-manager expire-generations "-7 days"
```

**Оптимизация хранилища Nix:**

```bash
# Сборка мусора
nix-store --gc

# Оптимизация (дедупликация файлов)
nix-store --optimize
```

### Управление записями загрузчика

**Список доступных поколений:**

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

**Удаление старых записей загрузчика:**

```bash
# Удаление конкретного поколения
sudo nix-env --delete-generations <generation_number> \
  --profile /nix/var/nix/profiles/system

# Сохранение только последних N поколений
sudo nix-env --delete-generations +<N> \
  --profile /nix/var/nix/profiles/system

# Пересборка загрузчика для отражения изменений
sudo nixos-rebuild boot --flake .#<hostName>
```

**Очистка всех старых поколений, кроме текущего:**

```bash
# Для NixOS
sudo nix-collect-garbage -d
sudo nixos-rebuild boot --flake .#<hostName>

# Для Home Manager
nix-collect-garbage -d
```

## Полезные ресурсы

### Официальная документация

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Disko Documentation](https://github.com/nix-community/disko)
- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)

### NixOS пакеты и опции

- [NixOS Search](https://search.nixos.org/)
- [MyNixOS](https://mynixos.com/)

### Home Manager пакеты и опции

- [Home Manager Options Search](https://nix-community.github.io/home-manager/options.xhtml)
- [Home Manager Configuration Options](https://mipmip.github.io/home-manager-option-search/)
- [Home Manager Appendix A](https://nix-community.github.io/home-manager/options.html)
