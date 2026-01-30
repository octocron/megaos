{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.nemo;
in
{
  options.apps.nemo = {
    enable = mkEnableOption "Nemo file manager";

    darkMode = mkOption {
      type = types.bool;
      default = true;
      description = "Enable dark mode theme";
    };

    defaultFileManager = mkOption {
      type = types.bool;
      default = false;
      description = "Set Nemo as the default file manager";
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        nemo
        nemo-fileroller
      ];

      # Nemo configuration
      variables = {
        NEMO_THEME = if cfg.darkMode then "Adwaita-dark" else "Adwaita";
      };

      # Default file manager settings
      sessionVariables = mkIf cfg.defaultFileManager {
        DEFAULT_FILE_MANAGER = "nemo";
      };
    };

    # Enable Cinnamon services for Nemo integration
    services.xserver.desktopManager.cinnamon.enable = mkDefault false;

    # GTK theme configuration for dark mode
    programs.dconf.enable = true;

    # Nemo dconf settings
    programs.dconf.profiles.nemo = {
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
              "sidebar-width" = 200;
            };
          };
        }
      ];
    };

    # Integration with Wayland
    home-manager.users = mkIf (config.users.users ? megacron) {
      megacron = {
        dconf.settings = {
          "org/nemo/preferences" = {
            inherit (cfg.darkMode) "dark-mode";
          };
        };

        # Ensure Nemo works properly in Wayland
        home.sessionVariables = {
          GDK_BACKEND = "wayland";
          CLUTTER_BACKEND = "wayland";
        };
      };
    };
  };
}

