{ pkgs, ... }: {
  #-----------------------BOOT--------------------------#
  # Choose either systemd (modern) or grub (legacy)
  boot = {
    loader = {
      systemd-boot.enable = false;
      timeout = 30;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;

        darkmatter-theme = {
          enable = true;
          style = "nixos";
          icon = "color";
          resolution = "1440p";
        };
      };
    };

    plymouth = {
      enable = true;
      extraConfig = ''
        DeviceScale=1
      '';
      theme = "circuit";
      # INFO: https://github.com/adi1090x/plymouth-themes
      # INFO: Favs: circuit colorful_loop darth_vader ironman optimus
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "circuit" ]; })
      ];
    };
  };
}
