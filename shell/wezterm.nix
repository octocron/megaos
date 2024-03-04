{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  programs.wezterm = {
    enable = true;
  };
}
