{ config, lib, pkgs, ... }:

{
  options = {
    steam.enable = lib.mkEnableOption "enables Steam with Proton support";
  };

  config = lib.mkIf config.steam.enable {
    home.packages = with pkgs; [
      steam
      protonup-qt
      mangohud
      gamemode
    ];

    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
    };

    home.activation.installProtonGE = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${config.home.homeDirectory}/.steam/root/compatibilitytools.d" ]; then
        ${pkgs.protonup-qt}/bin/protonup-qt --install-dir "${config.home.homeDirectory}/.steam/root/compatibilitytools.d" --no-gui --install proton-ge
      fi
    '';

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
        gpu = {
          apply_gpu_optimisations = "accept";
          gpu_device = 0;
        };
      };
    };
  };
}