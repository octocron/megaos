{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.hyprland;
in
{
  options.services.hyprland.enable = mkEnableOption "enable hyprland";

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}

