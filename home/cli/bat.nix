{ pkgs, ... }:
# INFO: Rust: ↑ cat
# NOTE: bat --list-themes
# NOTE: bat cache --build -> installs all themes to ~/.config/bat/themes
{
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
      pager = "less -FRK"; # INFO: [ -F exit if smaller than screen | -R Interpret ANSI colors | -K exit on interrupt ]
      style = "numbers,changes,header";
      map-syntax = [
        ".ignore:Git Ignore"
      ];
    };

    themes = {
      ansi = {
        src = pkgs.fetchFromGitHub {
          owner = "sharkdp";
          repo = "bat";
          rev = "2cec8cdf25c3bf1c5da5a9caf18caa5281333812";
          sha256 = "sha256-WZsdjSHlKyvd/h2FB6ck3r3PwgU3Zi+aMEYI2vaFEBU=";
        };
        file = "ansi.tmTheme";
      };
    };
  };
}
