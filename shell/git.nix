{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    userEmail = "${gitEmail}";
    userName = "${gitUsername}";
    extraConfig = {
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
