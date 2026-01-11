_: {
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
  };
}
