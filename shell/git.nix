{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    userEmail = "${gitEmail}";
    userName = "${gitUsername}";
    extraConfig = {
      # clone private https repos
      url = {
      #   "https://oauth2:${secrets.github_token}@github.com" = {
      #     insteadOf = "https://github.com";
      #   };
      # TODO: add rest of gitlab code related to this
        "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };

}
