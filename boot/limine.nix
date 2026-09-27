{
  pkgs,
  config,
  ...
}:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        style = {
          graphicalTerminal = {
            background = "65000000";
            foreground = "FFAA00";
            font.scale = "1x1";
          };

          interface = {
            branding = "megaOS by megacron";
            brandingColor = "5";
            helpColorBright = "1";
          };

          wallpaperStyle = "stretched"; # INFO: centered || stretched || tiled
          wallpapers = [
            #"${../media/wallpapers/frieren.jpg}"
            "${../media/wallpapers/tanjiro.jpg}"
          ];
        };
      };

      efi.canTouchEfiVariables = true;
      timeout = 20;
    };

    plymouth = {
      enable = true;
      extraConfig = ''
        DeviceScale=1
      '';
      theme = "optimus";
      # INFO: https://github.com/adi1090x/plymouth-themes
      # INFO: Favs: circuit colorful_loop darth_vader ironman optimus
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "optimus" ]; })
      ];
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    kernelParams = [ "quiet" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    binfmt = {
      # INFO: for testing pi with build-vm
      emulatedSystems = [ "aarch64-linux" ];
    };
  };
}
