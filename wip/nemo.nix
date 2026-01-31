# WARN: Too much gtk/cinnamon desktop needs, kinda busted.
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.nemo;
in
{
  options.services.nemo.enable = mkEnableOption "enable nemo";

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        nemo
        nemo-fileroller
      ];

      variables = {
        NEMO_THEME = "Adwaita-dark";
      };

      sessionVariables = {
        DEFAULT_FILE_MANAGER = "nemo";
      };
    };

    # ensure cinnamon does not start by default
    services.xserver.desktopManager.cinnamon.enable = mkDefault false;
    programs.dconf = {
      enable = true;
      profiles.nemo = {
        databases = [
          {
            settings = {
              "org/nemo/preferences" = {
                "show-advanced-permissions" = true;
                "show-hidden-files" = false;
                "show-location-entry" = true;
                "show-full-path-titles" = true;
                "close-device-view-on-device-eject" = true;
                "desktop-layout" = "true::true";
              };

              "org/nemo/window-state" = {
                "geometry" = "900x600+100+100";
                "maximized" = false;
                "sidebar-width" = lib.gvariant.mkInt32 200;
              };
            };
          }
        ];
      };
    };
  };
}
