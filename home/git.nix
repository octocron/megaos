{
  gitUsername,
  gitEmail,
  hostname,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      ignores = [
        ".direnv"
        "result"
        ".DS_Store"
      ];
      lfs.enable = true;

      signing = {
        format = "ssh";
        key = "~/.ssh/${hostname}.pub";
        signByDefault = true;
      };

      settings = {
        user = {
          email = "${gitEmail}";
          name = "${gitUsername}";
        };
        extraConfig = {
          core.editor = "nvim";
          diff.colorMoved = "default";
          init.defaultBranch = "trunk";
          merge.conflictstyle = "zdiff3";
          rerere.enabled = true;

          commit = {
            gpgsign = true;
            verbose = true;
          };
          push = {
            default = "current";
            autoSetupRemote = true;
          };
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        light = false;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };
  };
}
