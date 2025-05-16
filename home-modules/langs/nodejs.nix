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
      lib.forEach config.nodejs.versions (pkg: [
        pkg
        pkgs.yarn
        pkgs.pnpm
      ])
    );

    # Алиасы для конкретных версий
    programs.bash.shellAliases =
      let
        mkAlias = cmd: pkg: pathPkg: {
          name = "${cmd}_${pkg.version}";
          value = "${pathPkg}/bin/${cmd}";
        };
      in
      lib.listToAttrs (
        (lib.forEach config.nodejs.versions (pkg: mkAlias "node" pkg pkg)) ++
        (lib.forEach config.nodejs.versions (pkg: mkAlias "npm" pkg pkg)) ++
        (lib.forEach config.nodejs.versions (pkg: mkAlias "yarn" pkg pkgs.yarn)) ++
        (lib.forEach config.nodejs.versions (pkg: mkAlias "pnpm" pkg pkgs.pnpm))
      );
  };
}
