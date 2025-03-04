{ config, lib, pkgs, ... }:

{
  options = {
    nodejs.enable = lib.mkEnableOption "enables NodeJS";
    nodejs.versions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ pkgs.nodejs_20 ];
      description = "List of Node.js versions to install";
    };
  };

  config = lib.mkIf config.nodejs.enable {
    home.packages = lib.flatten (
      lib.mapAttrsToList (pkg: [
        pkg
        (pkg.override { npm = pkgs.npm; })
        pkgs.yarn
        pkgs.pnpm
      ]) config.nodejs.versions
    );

    # Алиасы для конкретных версий
    programs.bash.shellAliases = let
      mkAlias = cmd: pkg: pathPkg: {
        name = "${cmd}_${pkg.version}";
        value = "${pathPkg}/bin/${cmd}";
      };
    in lib.listToAttrs (
      (lib.mapAttrsToList (pkg: mkAlias "node" pkg pkg) config.nodejs.versions) ++
      (lib.mapAttrsToList (pkg: mkAlias "npm" pkg pkg) config.nodejs.versions) ++
      (lib.mapAttrsToList (pkg: mkAlias "yarn" pkg pkgs.yarn) config.nodejs.versions) ++
      (lib.mapAttrsToList (pkg: mkAlias "pnpm" pkg pkgs.pnpm) config.nodejs.versions)
    );
  };
}