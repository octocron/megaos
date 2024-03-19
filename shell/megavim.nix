{ pkgs, ... }:

let
  userVimPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "user";
    src = ../config/nvim;
  };
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      userVimPlugin
      pkgs.vimPlugins.lazy-nvim
    ];
    extraLuaConfig = ''
      require('megavim')
    '';
  };
}
