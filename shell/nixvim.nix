{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    extraPlugins = [ pkgs.vimPlugins.gruvbox ];
    colorschemes.gruvbox.enable = true;
  };
}

