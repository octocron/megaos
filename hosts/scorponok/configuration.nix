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
    #./nebula.nix
    ../../apps/sops.nix
  ];

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
        monospace = [
          "Maple Mono"
          "Noto Sans Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      maple-mono.opentype
      nerd-fonts.symbols-only
      nerd-fonts.noto
      noto-fonts-color-emoji
    ];
  };

  #-----------------INTERNATIONALISATION----------------#
  console.keyMap = "us";
  time.timeZone = theTimezone;
  i18n.defaultLocale = theLocale;

  #-------------------NETWORKING------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];

      allowedUDPPorts = [
        4242
      ];

      trustedInterfaces = [
        #"nebula.megaport"
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    };
  };

  #-----------------------SERVICES-----------------------#
  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "prohibit-password"; # prevent root from SSH login
        PasswordAuthentication = false; # users can SSH using username and password
        KbdInteractiveAuthentication = false; # allow keyboard based auth
      };
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
        linger = true; # NOTE: for restarting ollama service after reboot
        isNormalUser = true;
        description = username;
        extraGroups = [
          "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.passwordHash.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7Nb8wXQWd9H69U6TzPoE1MJDzUbGZSwwJCaXBvzgdb megacron"
        ];
      };
    };
  };
}
