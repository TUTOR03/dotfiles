{ config, lib, pkgs, ... }:

{
  options = {
    printers.enable = lib.mkEnableOption "enables printers support";
  };

  config = lib.mkIf config.printers.enable {
    home.packages = with pkgs; [
      cups
      hplip
      gutenprint
    ];
  };
}
