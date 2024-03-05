{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "a";
  };
}
