{ gitUsername, gitEmail, ... }:

{
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options = {
      light = false;
      line-numbers = true;
      navigate = true;
      side-by-side = true;
    };
    userEmail = "${gitEmail}";
    userName = "${gitUsername}";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      diff = {
        colorMoved = "default";
      };
      init = {
        defaultBranch = "trunk";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      merge = {
        conflictstyle = "diff3";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
    };
  };
}
