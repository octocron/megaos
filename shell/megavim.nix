{ pkgs, ... }:

let
  megavimVimPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "megavim";
    src = ../config/nvim;
  };
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      megavimVimPlugin
      pkgs.vimPlugins.lazy-nvim
    ];
    extraLuaConfig = ''
      require('megavim')
    '';
  };
}
