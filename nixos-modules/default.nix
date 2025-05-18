{ ... }:

{
  imports = [
    # Шаблон для всех хостов
    ./host.nix
    # Десктопы
    ./desktops/hyprland.nix
    # Сервисы
    ./services/xserver.nix
    ./services/openvpn.nix
  ];
}
