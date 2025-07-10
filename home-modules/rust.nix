{ config, lib, pkgs, ... }:

{
  options = {
    rust.enable = lib.mkEnableOption "enables Rust";
  };

  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs; [
      (rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
      })
    ];
  };
}
