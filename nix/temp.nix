# { config, pkgs, ... }:

# {
#   imports = [
#     ./hardware-configuration.nix
#   ];

#   boot.loader.systemd-boot.enable = true;
#   boot.loader.efi.canTouchEfiVariables = true;

#   nix.settings.experimental-features = [
#     "nix-command"
#     "flakes"
#   ];

#   networking.hostName = "nixos";

#   networking.networkmanager.enable = true;

#   time.timeZone = "Europe/Moscow";

#   i18n.defaultLocale = "en_US.UTF-8";

#   i18n.extraLocaleSettings = {
#     LC_ADDRESS = "ru_RU.UTF-8";
#     LC_IDENTIFICATION = "ru_RU.UTF-8";
#     LC_MEASUREMENT = "ru_RU.UTF-8";
#     LC_MONETARY = "ru_RU.UTF-8";
#     LC_NAME = "ru_RU.UTF-8";
#     LC_NUMERIC = "ru_RU.UTF-8";
#     LC_PAPER = "ru_RU.UTF-8";
#     LC_TELEPHONE = "ru_RU.UTF-8";
#     LC_TIME = "ru_RU.UTF-8";
#   };

#   services.xserver.enable = true;

#   services.xserver.displayManager.gdm.enable = true;
#   services.xserver.desktopManager.gnome.enable = true;

#   services.xserver.xkb = {
#     layout = "us";
#     variant = "";
#   };

#   services.printing.enable = true;

#   hardware.pulseaudio.enable = false;
#   security.rtkit.enable = true;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#   };

#   users.users.sdev = {
#     isNormalUser = true;
#     description = "sdev";
#     extraGroups = [
#       "networkmanager"
#       "wheel"
#     ];
#   };

#   nixpkgs.config.allowUnfree = true;

#   environment.systemPackages = with pkgs; [
#     home-manager
#   ];

#   system.stateVersion = "24.11";
# }