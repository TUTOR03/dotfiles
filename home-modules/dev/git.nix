{ config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";

    git.sshKeyPathGithub = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Path to SSH key for GitHub";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "TUTOR03";
      userEmail = "stukalov.dev@gmail.com";

      extraConfig = {
        init.defaultBranch = "master";
      };

      includes = [
        (lib.optional (config.git.sshKeyPathGithub != "") {
          condition = "hasconfig:remote.*.url:git@github.com:**";
          contents = {
            core.sshCommand = "ssh -i ${config.git.sshKeyPathGithub}";
          };
        })
      ];
    };
  };
}