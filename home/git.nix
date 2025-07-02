{
  gitUsername,
  gitEmail,
  ...
}: {
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options = {
      light = false;
      line-numbers = true;
      navigate = true;
      side-by-side = true;
    };
    ignores = [
      ".direnv"
      "result"
      ".DS_Store"
    ];
    userEmail = "${gitEmail}";
    userName = "${gitUsername}";
    lfs.enable = true;

    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
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
}
