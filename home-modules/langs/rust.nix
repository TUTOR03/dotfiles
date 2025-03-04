{ config, lib, pkgs, ... }:

{
  options = {
    rust.enable = lib.mkEnableOption "enables Rust";
  };

  config = lib.mkIf config.rust.enable {
    home.packages = let
      stableRust = pkgs.rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" "clippy" ];
      };
      nightlyRust = pkgs.rust-bin.nightly.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" "clippy" ];
      };
    in [
      stableRust
      nightlyRust
      pkgs.cargo-watch
      pkgs.cargo-edit
    ];

    programs.bash.shellAliases = {
      rustc = "${stableRust}/bin/rustc";
      cargo = "${stableRust}/bin/cargo";
      "rustc-nightly" = "${nightlyRust}/bin/rustc";
      "cargo-nightly" = "${nightlyRust}/bin/cargo";
    };
  };
}