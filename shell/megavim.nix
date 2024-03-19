{ pkgs, ... }:

let
  megavimPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "megavim";
    src = ../config/nvim;
  };
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      megavimPlugin
    ];
    extraLuaConfig = ''
      require('megavim')
    '';
  };
}
