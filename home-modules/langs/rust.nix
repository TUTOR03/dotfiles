{ config, lib, pkgs, ... }:

let
  stableRust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" "rust-analyzer" "clippy" ];
  };
in {
  options = {
    rust.enable = lib.mkEnableOption "enables Rust";
  };

  config = lib.mkIf config.rust.enable {
    home.packages = [
      stableRust
      pkgs.cargo-watch
      pkgs.cargo-edit
    ];

    programs.bash.shellAliases = {
      rustc = "${stableRust}/bin/rustc";
      cargo = "${stableRust}/bin/cargo";
    };
  };
}
