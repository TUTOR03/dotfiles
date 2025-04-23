{ config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";
    git.sshKeyPathGithub = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Path to SSH key for GitHub";
    };
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

      includes = lib.mkIf (config.git.sshKeyPathGithub != "") [
        {
          condition = "hasconfig:remote.*.url:git@github.com:**";
          contents = {
            core.sshCommand = "ssh -i ${config.git.sshKeyPathGithub}";
          };
        }
      ];
    };
  };
}