{
  lib,
  pkgs,
  username,
  ...
}:
with lib;
let
  cfg = config.services.greetd;
in
{
  options.services.greetd.enable = mkEnableOption "enable greetd";

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
  };
}
