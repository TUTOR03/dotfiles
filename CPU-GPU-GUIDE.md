# Руководство по настройке GPU в NixOS

## Введение

### Что настраивает services.xserver.videoDrivers

Параметр `services.xserver.videoDrivers` управляет драйверами графики для X11 и Wayland:

- **Kernel modules** - модули драйверов на уровне ядра
- **Mesa drivers** - OpenGL/Vulkan драйверы
- **DRM/KMS** - Direct Rendering Manager (используется Wayland)
- **DDX drivers** - драйверы для X11

Несмотря на название `xserver`, параметр работает и для Wayland.

### Доступные драйверы

| Драйвер       | Назначение                        | Когда использовать                              |
| ------------- | --------------------------------- | ----------------------------------------------- |
| `modesetting` | Универсальный современный драйвер | Intel iGPU, встроенная графика                  |
| `nvidia`      | Проприетарный NVIDIA              | Дискретные карты NVIDIA                         |
| `amdgpu`      | Драйвер для современных AMD       | AMD RX 400+, Ryzen APU                          |
| `radeon`      | Драйвер для старых AMD            | AMD до RX 400 (HD 7000, R9 200-300)             |
| `nouveau`     | Открытый драйвер NVIDIA           | ⚠️ Не рекомендуется (слабая производительность) |
| `intel`       | Устаревший Intel драйвер          | ⚠️ Deprecated, использовать `modesetting`       |

---

## Одиночные GPU

### Intel (встроенная графика)

**Применение:** Процессоры Intel со встроенной графикой (iGPU)

```nix
{
  services.xserver.videoDrivers = [ "modesetting" ];
}
```

**Особенности:**

- Отличная поддержка Wayland из коробки
- Дополнительная настройка не требуется
- Драйвер `intel` устарел, всегда используйте `modesetting`

---

### AMD (встроенная или дискретная)

**Применение:**

- Процессоры AMD с iGPU (Ryzen APU)
- Дискретные видеокарты AMD

#### Современные AMD (RX 400+, Vega, Navi, RDNA)

```nix
{
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu = {
    opencl.enable = true;   # Поддержка вычислений OpenCL
    amdvlk.enable = true;   # Vulkan драйвер от AMD
  };
}
```

#### Старые AMD (до RX 400)

```nix
{
  services.xserver.videoDrivers = [ "radeon" ];
}
```

**Особенности:**

- Отличная поддержка Wayland
- Открытые драйверы в ядре Linux
- Стабильная работа без дополнительных настроек

---

### NVIDIA (дискретная)

**Применение:** Дискретные видеокарты NVIDIA

#### Стационарный ПК

```nix
{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;              # Обязательно для Wayland
    powerManagement.enable = false;         # Не требуется для десктопа
    open = false;                           # Проприетарный драйвер (стабильнее)
    nvidiaSettings = true;                  # GUI для настроек
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
```

#### Ноутбук (без гибридной графики)

```nix
{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;          # Важно для ноутбуков
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
```

**Особенности:**

- `modesetting.enable = true` обязателен для Wayland
- Для Wayland нужны дополнительные настройки (см. раздел Wayland)

---

## Гибридная графика (PRIME)

### Определение Bus ID

Перед настройкой нужно узнать Bus ID ваших GPU:

```bash
lspci | grep -E "VGA|3D"
```

**Пример вывода:**

```text
00:02.0 VGA compatible controller: Intel Corporation
01:00.0 3D controller: NVIDIA Corporation
46:00.0 VGA compatible controller: NVIDIA Corporation
```

**Конвертация в NixOS формат:**

- `00:02.0` → `PCI:0:2:0`
- `01:00.0` → `PCI:1:0:0`
- `46:00.0` → `PCI:46:0:0`

**Правило:** Убрать ведущие нули, формат `PCI:XX:YY:Z`

---

### Intel iGPU + NVIDIA dGPU

#### Стационарный ПК

**Рекомендация:** Режим `sync` - всегда используем NVIDIA для рендеринга

```nix
{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";    # Заменить на свой Bus ID
      nvidiaBusId = "PCI:1:0:0";   # Заменить на свой Bus ID

      sync.enable = true;           # NVIDIA рендерит, Intel выводит
    };
  };
}
```

**Зачем sync на десктопе:**

- Энергопотребление не критично
- Максимальная производительность
- Лучшая совместимость

---

#### Ноутбук

**Рекомендация:** Режим `offload` - Intel по умолчанию, NVIDIA по требованию

```nix
{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;  # Динамическое управление питанием
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";         # Заменить на свой Bus ID
      nvidiaBusId = "PCI:1:0:0";        # Заменить на свой Bus ID

      offload = {
        enable = true;                   # Режим offload
        enableOffloadCmd = true;         # Создает команду nvidia-offload
      };
    };
  };

  # Вспомогательный скрипт для запуска приложений на NVIDIA
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
```

**Зачем offload на ноутбуке:**

- Экономия заряда батареи
- Intel работает постоянно (низкое энергопотребление)
- NVIDIA включается только для тяжелых приложений

**Другие режимы PRIME:**

- `reverseSync.enable = true` - для внешнего монитора, подключенного к NVIDIA

---

### AMD iGPU + NVIDIA dGPU

#### Стационарный ПК

**Рекомендация:** Режим `sync` - всегда используем NVIDIA

```nix
{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      amdgpuBusId = "PCI:16:0:0";   # Заменить на свой Bus ID (AMD)
      nvidiaBusId = "PCI:1:0:0";    # Заменить на свой Bus ID (NVIDIA)

      sync.enable = true;
    };
  };
}
```

---

#### Ноутбук

**Рекомендация:** Режим `offload` - AMD по умолчанию, NVIDIA по требованию

```nix
{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      amdgpuBusId = "PCI:5:0:0";    # Заменить на свой Bus ID (AMD)
      nvidiaBusId = "PCI:1:0:0";    # Заменить на свой Bus ID (NVIDIA)

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
```

---

### Intel iGPU + AMD dGPU

**Применение:** Редкая конфигурация

```nix
{
  services.xserver.videoDrivers = [ "modesetting" "amdgpu" ];
}
```

**Переключение GPU:**

```bash
DRI_PRIME=1 your-app  # Запуск на AMD dGPU
```

---

## Настройки для Wayland

### NVIDIA + Wayland (обязательные настройки)

Для работы NVIDIA с Wayland требуются дополнительные параметры:

```nix
{
  # Включение kernel mode setting для NVIDIA DRM
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Загрузка модулей NVIDIA в initrd
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  # Переменные окружения
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Wayland для Chromium/Electron приложений
  };
}
```

**При проблемах с курсором:**

```nix
environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  WLR_NO_HARDWARE_CURSORS = "1";  # Отключить аппаратный курсор
};
```

---

### AMD/Intel + Wayland

Для AMD и Intel дополнительная настройка **не требуется** - Wayland работает из коробки.

---

## Использование PRIME Offload

При включенном режиме `offload` встроенная графика (iGPU) работает по умолчанию, а дискретная (dGPU) включается только при необходимости.

### Запуск приложений на дискретной GPU

```bash
# Для NVIDIA
nvidia-offload steam
nvidia-offload blender
nvidia-offload your-game

# Для AMD (в конфигурации Intel + AMD)
DRI_PRIME=1 your-app
```

### Проверка какой GPU используется

```bash
# Показать текущий активный GPU
glxinfo | grep "OpenGL renderer"

# Для NVIDIA - мониторинг нагрузки
nvidia-smi

# Для AMD - мониторинг
radeontop
```

---

## Диагностика

### Проверка системы

```bash
# Проверить тип сессии (x11 или wayland)
echo $XDG_SESSION_TYPE

# Проверить активный GPU
glxinfo | grep "OpenGL renderer"

# Показать все GPU в системе
lspci | grep -E "VGA|3D"

# Проверить загруженные модули NVIDIA
lsmod | grep nvidia
# Должны быть: nvidia, nvidia_drm, nvidia_modeset, nvidia_uvm

# Проверить статус NVIDIA modeset (должен быть Y)
cat /sys/module/nvidia_drm/parameters/modeset

# Мониторинг NVIDIA GPU
nvidia-smi

# Информация о Wayland
echo $WAYLAND_DISPLAY
```

### Тестирование производительности

```bash
# Простой тест FPS
glxgears -info

# Без ограничения FPS
vblank_mode=0 glxgears

# Vulkan тест
vkcube

# Проверка что приложение использует нужный GPU
__NV_PRIME_RENDER_OFFLOAD=1 glxinfo | grep "OpenGL renderer"
```

---

## Решение проблем

### Мерцающий курсор в Wayland (NVIDIA)

**Симптомы:** Курсор мерцает или исчезает в Wayland

**Решение:**

```nix
environment.sessionVariables = {
  WLR_NO_HARDWARE_CURSORS = "1";
};
```

---

### NVIDIA не работает в Wayland

**Симптомы:** Сессия не запускается или падает в X11

**Проверить:**

1. `hardware.nvidia.modesetting.enable = true` - установлен?
2. `boot.kernelParams = [ "nvidia-drm.modeset=1" ]` - добавлен?
3. `boot.initrd.kernelModules` - содержит модули NVIDIA?

**Проверка modeset:**

```bash
cat /sys/module/nvidia_drm/parameters/modeset
# Должен быть: Y
```

---

### Низкая производительность на ноутбуке

**Симптомы:** Игры или 3D приложения тормозят

**Причина:** Приложение работает на iGPU вместо dGPU

**Решение:**

```bash
nvidia-offload your-game
```

**Постоянное решение для конкретного приложения:**
Создать desktop-файл с модифицированным Exec:

```
Exec=nvidia-offload steam %U
```

---

### Неправильный Bus ID

**Симптомы:** PRIME не работает, ошибки в логах

**Диагностика:**

```bash
lspci | grep -E "VGA|3D"
```

**Решение:** Исправить значения `intelBusId`, `nvidiaBusId`, `amdgpuBusId` в конфигурации

---

### Черный экран при загрузке (NVIDIA)

**Причина:** Модули NVIDIA не загружаются в initrd

**Решение:**

```nix
boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
```

---

## Сводная таблица рекомендаций

| Конфигурация   | Десктоп                    | Ноутбук                    | Режим PRIME    |
| -------------- | -------------------------- | -------------------------- | -------------- |
| Intel iGPU     | `["modesetting"]`          | `["modesetting"]`          | —              |
| AMD iGPU/dGPU  | `["amdgpu"]`               | `["amdgpu"]`               | —              |
| NVIDIA dGPU    | `["nvidia"]`               | `["nvidia"]` + PM          | —              |
| Intel + NVIDIA | `["nvidia"]`               | `["modesetting" "nvidia"]` | sync / offload |
| AMD + NVIDIA   | `["nvidia"]`               | `["amdgpu" "nvidia"]`      | sync / offload |
| Intel + AMD    | `["modesetting" "amdgpu"]` | `["modesetting" "amdgpu"]` | DRI_PRIME      |

**Обозначения:**

- **PM** - `powerManagement.enable = true`
- **sync** - для десктопа (максимальная производительность)
- **offload** - для ноутбука (экономия батареи)
