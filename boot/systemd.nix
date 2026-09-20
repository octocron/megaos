# NOTE: [systemd-analyze time] will show the time it takes to boot
# NOTE: [systemd-analyze critical-chain] shows path units in userscpace
# NOTE: [systemd-analyze plot > plot.svg] to create a graphical visualization
{
  pkgs,
  config,
  ...
}:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        netbootxyz.enable = false;
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
    };
  };
}
