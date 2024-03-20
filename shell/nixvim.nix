{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    extraPlugins = [
      pkgs.vimPlugins.gruvbox
      pkgs.vimPlugins.base16-nvim
    ];
    colorschemes.gruvbox.enable = true;
  };
}

