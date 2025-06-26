{
  pkgs,
  inputs,
  username,
  hostname,
  theLocale,
  theTimezone,
  gitUsername,
  ...
}: {
  #----------------------NixOS-MODULES---------------#
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #./app/crowdsec.nix
    #./app/tailscale.nix
  ];

  #-----------------------BOOT-----------------------#
  # Choose either systemd (modern) or grub (legacy)
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    timeout = 30;
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

  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  #-----------------------ENVIRONMENT-------------------#
  environment = {
    systemPackages = with pkgs; [
      (pkgs.nnn.override {withNerdIcons = true;})
      # bazecore
      cifs-utils # for mounting SMB shares
      curl
      file
      git
      parted
      polychromatic
      vim
      wget
      zsh
    ];

    variables = {
      NIXOS_OZONE_WL = "1";
      PATH = [
        "\${HOME}/.local/bin"
        "\${HOME}/.cargo/bin"
        "\$/usr/local/bin"
      ];
      NIXPKGS_ALLOW_UNFREE = "1";
      SCRIPTDIR = "\${HOME}/.local/share/scriptdeps";
      STARSHIP_CONFIG = "\${HOME}/.config/starship.toml";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland";
      CLUTTER_BACKEND = "wayland";
      SDL_VIDEODRIVER = "x11";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  #------------------FONTS-SYSTEMWIDE------------------#
  fonts.packages = with pkgs; [
    ipafont
    nerdfonts
    maple-mono-NF
  ];

  #-----------------------HARDWARE---------------------#
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    openrazer = {
      enable = true;
      users = ["$username"];
    };
    pulseaudio.enable = false;
  };

  #-----------------INTERNATIONALISATION----------------#
  time.timeZone = "${theTimezone}";
  i18n = {
    defaultLocale = "${theLocale}";
    extraLocaleSettings = {
      LC_ADDRESS = "${theLocale}";
      LC_IDENTIFICATION = "${theLocale}";
      LC_MEASUREMENT = "${theLocale}";
      LC_MONETARY = "${theLocale}";
      LC_NAME = "${theLocale}";
      LC_NUMERIC = "${theLocale}";
      LC_PAPER = "${theLocale}";
      LC_TELEPHONE = "${theLocale}";
      LC_TIME = "${theLocale}";
    };
  };

  #-----------------NETWORKING------------------------#
  networking = {
    hostName = "${hostname}"; # Defines hostname.
    networkmanager.enable = true;
    nftables.enable = true;
    wireless.enable = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443];
      allowedUDPPorts = [22 80 443];
      #trustedInterfaces = [ "tailscale0" ];
    };
    #proxy = {
    #  default = "http://user:password@proxy:port/";
    #  noProxy = "127.0.0.1,localhost,internal.domain";
    #};
  };

  #-----------------NIX-OPTIMIZATIONS------------------#
  nix = {
    nrBuildUsers = 64;
    settings = {
      cores = 0; # 0 means all available cores
      warn-dirty = false;
      auto-optimise-store = true;
      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;
      max-jobs = "auto";
      trusted-users = ["root" "@wheel"];
      allowed-users = ["root" "@wheel"];
      experimental-features = ["flakes" "nix-command"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # optimise nix builders (keep from running out of memory)
  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # For when dangon devs use EOL dependencies, grrrr..
    ];
  };

  #-----------------------PROGRAMS-----------------------#
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    gamemode.enable = true;
    thunar.enable = true;
    mtr.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    zsh = {
      enable = true;
    };
  };

  #-----------------------SECURITY-----------------------#
  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults      timestamp_timeout=1800
    '';
  };

  #-----------------------SERVICES-----------------------#
  services = {
    # List services that should be enabled:
    fstrim.enable = true;
    gvfs.enable = true; # allow gtk based file managers to browse samba shares
    mullvad-vpn.package = pkgs.mullvad-vpn;
    openssh.enable = true;
    printing.enable = false;
    tumbler.enable = true;

    avahi = {
      publish.enable = true;
      publish.userServices = true;
      nssmdns = true;
      enable = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # still need to $ sudo smbpasswd -a $username
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "server smb encrypt" = "required";
          "server min protocol" = "SMB3";
        };
      };
    };

    samba-wsdd = {
      # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      videoDrivers = ["amdgpu"];
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
        autoLogin.enable = true;
        autoLogin.user = "${username}";
      };
    };
  };

  #-----------------------SYSTEM-----------------------#
  system = {
    stateVersion = "23.11";
    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
             /run/current-system "$systemConfig"
      '';
    };
  };

  #-----------------------USERS-----------------------#
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCFpd0UZyX1T0WewVnzEWYY+9oXX+JcJaTLusO33/FX ansible"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHPOPzh8vu5f8/T5IbbD6/1tzpnH94EPcta7FS2vUy45 optimus"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1ZJSRTAzfmHNMDLWHKEm1oCr82v8zYvoaMVAvIGZdp galvatron"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYwMb4RRHkA0WL+TF9XtW54hqu4XrY2yLsF7b+9PCdY blackout.local"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPnQdwT0HIgx43nv37wrepEAn6BDeP0uxLT/KDKAHE/ energon"
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBG++DllhoaxmTnSQ155B0dgEbRO+XHsXP8a3znDm8YesXYcct+cDvV1ysf7HEP/9jaQmrbOSXKtdC1bA3fYU4mk= drift"
      ];
    };
  };
}
