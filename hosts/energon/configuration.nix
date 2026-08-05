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
    ./nebula.nix
    ../../apps
    ../../boot/limine.nix
    ../../core
    ../../drivers
    ../../users/megacron.nix
  ];

  #-----------------------DRIVERS----------------------#
  drivers = {
    amd.enable = true;
    intel.enable = false;
    nvidia.enable = true;
    nvidiaPrime.enable = false;
  };

  #-----------------------ENVIRONMENT------------------#
  environment.systemPackages = with pkgs; [
    #adwaita-icon-theme
    glib # needed for gsettings
    nebula # GO: overlay mesh network
    polychromatic # for razor keyboards and mice
    xdg-utils
  ];

  #-----------------------HARDWARE---------------------#
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # NOTE: used to opengl
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # NOTE: Razor Keyboard Support
    openrazer = {
      enable = true;
      users = [ "${username}" ];
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

    dconf.enable = true;
    xfconf.enable = true;
    mtr.enable = true;

    nh = {
      enable = true;
      flake = "/home/${username}/projects/megaos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 40d --keep 10";
      };
    };

    ssh.startAgent = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    zsh = {
      enable = true;
    };
  };

  #-----------------------SERVICES-----------------------#
  services = {
    # Choose Desktop in flake.nix
    hyprland.enable = desktop == "hyprland";
    niri.enable = desktop == "niri";

    # List services that should be enabled:
    fstrim.enable = true; # ssd optimizer
    libinput.enable = true; # input handler
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    nfs.enable = false;
    printing.enable = false;
    udisks2.enable = true; # USB auto mounting
    pulseaudio.enable = false;

    # Needed for File Managers
    gvfs.enable = true; # allow gtk based file managers to browse samba shares
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

    blueman.enable = true;

    caddy.enable = false;
    goxlr-utility = {
      enable = true;
      autoStart.xdg = true;
    };

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
      wireplumber.enable = true;
    };

    podman.enable = true;
    # steam-servers = {
    #   satisfactory = {
    #     enable = true;
    #     autoStart = false;
    #     experimental = false;
    #     installDir = "/var/lib/satisfactory";
    #     openFirewall = false; # false when using nebula
    #   };
    # };

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
