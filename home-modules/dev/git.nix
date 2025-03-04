{ config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";
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
        {
          condition = "hasconfig:remote.*.url:git@github.com:**";
          contents = {
            core.sshCommand = "ssh -i ~/.ssh/id_rsa_github";
          };
        }
      ];
    };
  };
}