{ config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";
    git.userName = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Git user name";
    };
    git.userEmail = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Git user email";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.git.userName;
      userEmail = config.git.userEmail;

      extraConfig = {
        init.defaultBranch = "master";
      };
    };
  };
}