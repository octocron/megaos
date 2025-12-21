{ pkgs, ... }:
{
  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.3;
      };
      closeOnClick = false;
      hideIcons = false;
      hidePluginInfo = false;
      ignoreExclusiveZones = true;
      layer = "overlay"; # [ background bottom overlay top ]
      maxEntries = null;
      showResultsImmediately = false;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libdictionary.so"
        "${pkgs.anyrun}/lib/libnix_run.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/libtranslate.so"
      ];
    };

    #Inline comments are supported for language injection into
    #multi-line strings with Treesitter! (Depends on your editor)
    extraCss = /* css */ '''';

    extraConfigFiles."some-plugin.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
        // refer to docs of xdg.configFile for available options
      )
    '';
  };
}
