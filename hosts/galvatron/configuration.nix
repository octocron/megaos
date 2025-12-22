{
  lib,
  pkgs,
  config,
  options,
  inputs,
  username,
  hostname,
  theLocale,
  theTimezone,
  gitUsername,
  ...
}:
{
  #----------------------NixOS-MODULES-----------------#
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../apps
  ];

  #-----------------------BOOT--------------------------#
  # Choose either systemd (modern) or grub (legacy)
  boot.loader = {
    #-----------Systemd---------------------------------#
    systemd-boot.enable = false;
    #efi.canTouchEfiVariables = true;
    #---------------------------------------------------#
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

    # for tailscale exit node
    #kernel.sysctl = {
    #  "net.ipv6.conf.all.forwarding" = "1";
    #};
  };

  #-----------------------ENVIRONMENT-------------------#
  environment = {
    systemPackages = with pkgs; [
      inputs.megavim.packages.${pkgs.system}.default
      # bazecore
      brightnessctl
      cifs-utils # for mounting SMB shares
      curl
      file
      ffmpegthumbnailer
      git
      networkmanagerapplet
      nix-output-monitor
      nvd
      parted
      pipewire
      sddm-astronaut
      tailscale
      uwsm # universal wayland session manager
      vim
      wget
      zsh
    ];

    variables = {
      PATH = [
        "\${HOME}/.local/bin"
        "\${HOME}/.cargo/bin"
        "\$/usr/local/bin"
      ];
      SCRIPTDIR = "\${HOME}/.local/share/scriptdeps";
      STARSHIP_CONFIG = "\${HOME}/.config/starship.toml";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };

  #------------------FONTS-SYSTEM-WIDE------------------#
  fonts.packages = with pkgs; [
    ipafont
    maple-mono.opentype
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.ubuntu
  ];

  #-----------------------HARDWARE---------------------#
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable; # could also use latest
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };

    openrazer = {
      enable = true;
      users = [ "$username" ];
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
  };

  #-----------------INTERNATIONALISATION----------------#
  console.keyMap = "us";
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
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    wireless.enable = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      trustedInterfaces = [ "tailscale0" ];
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
      cores = 2; # 0 means all available cores
      warn-dirty = false;
      auto-optimise-store = true;
      download-buffer-size = 240 * 1024 * 1024;
      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;
      max-jobs = 4; # "auto" means all, 0 means use remote specified in builders
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
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # optimise nix builders (keep from running out of memory)
  systemd = {
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    }; # give more time for services to shutdown gracefully
    services = {
      nix-daemon.serviceConfig = {
        MemoryAccounting = true;
        MemoryMax = "90%";
        OOMScoreAdjust = 500;
      };

      tailscale-autoconnect = {
        description = "Automatic connection to Tailscale";
        # make sure tailscale is running before trying to connect
        after = [
          "network-pre.target"
          "tailscale.service"
        ];
        wants = [
          "network-pre.target"
          "tailscale.service"
        ];
        wantedBy = [ "multi-user.target" ];
        # set this service as a oneshot job
        serviceConfig.Type = "oneshot";
        # have the job run this shell script
        script = with pkgs; ''
          # wait for tailscaled to settle
          sleep 2
          # check if we are already authenticated to tailscale
          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then
            exit 0
          fi
          # otherwise authenticate with tailscale
          ${tailscale}/bin/tailscale up --auth-key file:/etc/tailscale/tskey-reusable
        '';
      };
    };
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
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    hyprlock.enable = true;

    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;

    nh = {
      enable = true;
      flake = "/home/${username}/projects/megaos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 40d --keep 10";
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    zsh = {
      enable = true;
    };
  };

  #-----------------------SECURITY-----------------------#
  security = {
    rtkit.enable = true;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "${username}" ];
          keepEnv = true;
          noPass = false;
        }
        {
          groups = [ "wheel" ];
          noPass = false; # Allows passwordless execution
        }
      ];
    };

    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ( subject.isInGroup("users") && (
           action.id == "org.freedesktop.login1.reboot" ||
           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
           action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          ))
          { return polkit.Result.YES; }
        })
      '';
    };
    pam.services.swaylock = {
      text = ''auth include login '';
    };
    sudo.extraConfig = ''
      Defaults      timestamp_timeout=1800
    '';
  };

  #-----------------------SERVICES-----------------------#
  services = {
    # List services that should be enabled:
    fstrim.enable = true; # ssd optimizer
    gvfs.enable = true; # allow gtk based file managers to browse samba shares
    libinput.enable = true; # input handler
    mullvad-vpn.package = pkgs.mullvad-vpn;
    nfs.server.enable = false; # NFS
    printing.enable = false;
    #pulseaudio.enable = false;
    rpcbind.enable = false; # NFS
    tailscale.enable = true;
    tumbler.enable = true; # image/video previewer

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    openssh = {
      enable = false;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no"; # prevent root from SSH login
        PasswordAuthentication = true; # users can SSH using username and password
        KbdInteractiveAuthentication = true; # allow keyboard based auth
      };
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

    steam-servers = {
      satisfactory = {
        enable = true;
        autoStart = false;
        experimental = false;
        installDir = "/var/lib/satisfactory";
        openFirewall = false; # false when using tailscale
      };
    };

    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  #-----------------------SYSTEM-----------------------#
  system = {
    stateVersion = "23.11";
    #activationScripts.diff = {
    #  supportsDryActivation = true;
    #  text = ''
    #    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
    #         /run/current-system "$systemConfig"
    #  '';
    #};
  };

  #-----------------------USERS-----------------------#
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "audio"
        "docker"
        "libvirtd"
        "networkmanager"
        "qemu-libvirtd"
        "scanner"
        "video"
        "wheel"
      ];
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
