{ config, lib, pkgs, ... }:

{
  options = {
    vlc.enable = lib.mkEnableOption "enables VLC media player";
  };

  config = lib.mkIf config.vlc.enable {
    home.packages = with pkgs; [
      (vlc.override {
        # Полная версия FFmpeg
        ffmpeg = ffmpeg_7-full;
        # Аппаратное ускорение для Intel/AMD/NVIDIA
        libva = libva;
        libvdpau = libvdpau;
      })
    ];
  };
}