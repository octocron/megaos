{
  config,
  pkgs,
  hostname,
  username,
  theLocale,
  theTimezone,
  ...
}:
{
  system.stateVersion = "26.05";
  #----------------------NixOS-MODULES-----------------#
  imports = [
    ./caddy.nix
    ./disko.nix
    ./motd.nix
    ./nebula.nix
    ../../apps/hermes.nix
    ../../apps/jellyfin.nix
    ../../apps/satisfactory.nix
    ../../apps/sops.nix
    ../../containers/metube.nix
    ../../containers/podman.nix
    ../../drivers
  ];

  #-----------------------BOOT-------------------------#
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # INFO: sudo zfs create -o recordsize=1M vault/movies
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      devNodes = "/dev/disk/by-id";
      extraPools = [ "vault" ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    swapDevices = 1;
  };

  #-----------------------DRIVERS----------------------#
  drivers = {
    amd.enable = true;
    intel.enable = false;
    nvidia.enable = false;
    nvidiaPrime.enable = false;
  };

  #-----------------------ENVIRONMENT------------------#
  environment = {
    systemPackages = with pkgs; [
      curl
      file
      git
      nebula # GO: overlay mesh network
      vim
      wget
      zsh
    ];

    sessionVariables = {
    };
  };

  #------------------FONTS-SYSTEM-WIDE------------------#
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "IPAGothic"
        ];
        serif = [
          "Noto Serif"
          "IPAMincho"
        ];
        monospace = [
          "Maple Mono"
          "Noto Sans Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      ipafont
      font-awesome
      maple-mono.opentype
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.noto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };

  #-----------------------HARDWARE---------------------#
  hardware = {
    enableRedistributableFirmware = true;
    # NOTE: used to opengl
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  #-----------------INTERNATIONALISATION----------------#
  console.keyMap = "us";
  time.timeZone = theTimezone;
  i18n.defaultLocale = theLocale;

  #-------------------NETWORKING------------------------#
  networking = {
    # INFO: head -c4 /dev/urandom | od -A none -t x4
    hostId = "8a1d156e";
    hostName = hostname; # Defines hostname.
    nftables.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowedTCPPorts = [
        22
        443
        9119 # hermes dashboard/desktop
      ];

      allowedUDPPorts = [
        4242
      ];

      interfaces.enp9s0 = {
        allowedTCPPorts = [
          7777
          8888
        ];

        allowedUDPPorts = [ 7777 ];
      };

      trustedInterfaces = [
        "nebula.megaport"
      ];
    };
  };

  #-------------------NIX-----------------------------#
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
      allowed-users = [
        "root"
        "${username}"
        "@wheel"
      ];
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  #-----------------------PROGRAMS-----------------------#
  programs = {
    mtr.enable = true;

    zsh = {
      enable = true;
    };
  };

  #-----------------------SECURITY-----------------------#
  security = {
    polkit.enable = true;

    sudo = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
      extraRules = [
        {
          users = [ "${username}" ];
          commands = [
            {
              command = "/run/current-system/sw/bin/podman";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };

  #-----------------------SERVICES-----------------------#
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    cron = {
      enable = true;
      systemCronJobs = [
        ''0 4 * * * root mkdir -p /vault/sf-backups/gooberville && tar -czf /vault/sf-backups/gooberville/saves-$(date +\%Y\%m\%d).tar.gz -C /var/lib/satisfactory .config/Epic/FactoryGame/Saved/SaveGames''
        "0 5 * * 0 root find /vault/sf-backups/gooberville -name 'saves-*.tar.gz' -mtime +30 -delete"
      ];
    };

    getty.autologinUser = username;

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "prohibit-password"; # prevent root from SSH login
        PasswordAuthentication = false; # if users can SSH using username and password
        KbdInteractiveAuthentication = false; # allow keyboard based auth
      };
    };

    steam-servers = {
      satisfactory = {
        enable = true;
        autoStart = true;
        experimental = false;
        installDir = "/var/lib/satisfactory";
        openFirewall = false; # NOTE: false when using vpn
      };
    };

    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  #-----------------------SYSTEMD----------------------------#
  systemd = {
    # INFO: give more time for services to shutdown gracefully
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
    services = {
      # INFO: optimise nix builders (keep from running out of memory)
      nix-daemon.serviceConfig = {
        MemoryAccounting = true;
        MemoryMax = "90%";
        OOMScoreAdjust = 500;
      };
    };
  };

  #-----------------------USERS----------------------------#
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      "${username}" = {
        homeMode = "755";
        uid = 1000;
        isNormalUser = true;
        description = username;
        extraGroups = [
          "wheel"
        ];

        # NOTE: mkpasswd -m sha-512
        #hashedPassword = "$6$MWayoxSTtPM9Q5rM$tB4FmVIjQ0WhycIHpeWhFl4lPM6xqjzvIrh64CmccxxzWS7ULvhh83qGLXCoY7AH5CrSZjwWPZQdF2olpcSeJ1";
        hashedPasswordFile = config.sops.secrets.passwordHash.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7Nb8wXQWd9H69U6TzPoE1MJDzUbGZSwwJCaXBvzgdb megacron"
        ];
      };
    };
  };
}
