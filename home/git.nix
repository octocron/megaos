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

      settings = {
        user = {
          email = "${gitEmail}";
          name = "${gitUsername}";
        };
        signing = {
          format = "ssh";
          key = "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILQkS/p/7w4lS2K+sTKJ8VPLjPCio6h/weQ9bWuaGIQi gitlab";
          signByDefault = true;
        };
        extraConfig = {
          core.editor = "nvim";
          diff.colorMoved = "default";
          init.defaultBranch = "trunk";
          merge.conflictstyle = "zdiff3";
          rerere.enabled = true;
          commit = {
            #gpgsign = true;
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
