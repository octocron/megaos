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
          wallpapers = [
            "${../media/wallpapers/optilast.jpg}"
            #"${../media/wallpapers/carafe_rainbow.png}"
          ];
          wallpaperStyle = "centered"; # INFO: centered || stretched || tiled
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
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    binfmt = {
      # INFO: for testing pi with build-vm
      emulatedSystems = [ "aarch64-linux" ];
      # INFO: Appimage Support
      registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
      };
    };
  };
}
