{
  desktop,
  pkgs,
  username,
  ...
}:
{
  #----------------------NixOS-MODULES-----------------#
  imports = [
    ./hardware-configuration.nix
    ../../apps
    ../../boot/grub.nix
    ../../core
    ../../drivers
    ../../users/megacron.nix
  ];

  #-----------------------DRIVERS----------------------#
  drivers = {
    amd.enable = false;
    intel.enable = true;
    nvidia.enable = true;
    nvidiaPrime.enable = false;
  };

  #-----------------------ENVIRONMENT------------------#
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  #-----------------------HARDWARE---------------------#
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    enableRedistributableFirmware = true;

    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
  };

  #-----------------------PROGRAMS-----------------------#
  programs = {
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

  #-----------------------SERVICES-----------------------#
  services = {
    # Desktop services
    hyprland.enable = desktop == "hyprland";
    niri.enable = desktop == "niri";

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

    caddy.enable = false;
    minecraft.enable = false;

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

    podman.enable = true;

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

    unbound.enable = false;

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
  };
}
