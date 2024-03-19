{ pkgs, ... }:

let
  megavim = pkgs.vimUtils.buildVimPlugin {
    name = "megavim";
    src = ../config/nvim;
  };
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      megavim
      pkgs.vimPlugins.lazy-nvim
    ];
#    extraLuaConfig = ''
#      require('megavim')
#    '';
  };
}
