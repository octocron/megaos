{
  gitUsername,
  gitEmail,
  ...
}: {
  programs = {
    git = {
      enable = true;
      ignores = [
        ".direnv"
        "result"
        ".DS_Store"
      ];
      lfs.enable = true;

      settings = {
        user = {
          email = "${gitEmail}";
          name = "${gitUsername}";
        };
        extraConfig = {
          gpg = {
            ssh = "~/.ssh/allowed_signers";
          };
          user.signingkey = "~/.ssh/id_galvatron.pub";
          core.editor = "nvim";
          diff.colorMoved = "default";
          init.defaultBranch = "trunk";
          merge.conflictstyle = "zdiff3";
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
      options = {
        light = false;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };
  };
}
