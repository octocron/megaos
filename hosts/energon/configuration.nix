{
  pkgs,
  username,
  ...
}:
{
  system.stateVersion = "23.11";
  #----------------------NixOS-MODULES-----------------#
  imports = [
    ./hardware-configuration.nix
    ./caddy.nix
    ./nebula.nix
    ./nfs.nix

    ../../apps/appimage.nix
    ../../apps/ollama.nix
    ../../apps/sddm.nix
    ../../apps/sops.nix

    ../../containers/podman.nix
    ../../containers/samba.nix
    ../../containers/windows.nix

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
  environment = {
    systemPackages = with pkgs; [
      # bazecore
      brightnessctl
      ffmpegthumbnailer
      glib # needed for gsettings
      networkmanagerapplet
      polychromatic # for razor keyboards and mice
      uwsm
      wayland
      xdg-utils

      # INFO: bevy rust projects need:
      alsa-lib
      clang
      libxcursor
      libxi
      libx11
      libxrandr
      libGL
      lld
      libxkbcommon
      pkg-config
      udev
      vulkan-loader
      vulkan-tools
    ];

    sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      GDK_BACKEND = "wayland,x11";
      GTK_USE_PORTAL = "1";
      HOTKEY_OVERLAY = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      XDG_SESSION_TYPE = "wayland";

      # INFO: Rust projects
      WINIT_UNIX_BACKEND = "wayland";

      # INFO: NVIDIA Gaming Optimizations
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      PROTON_ENABLE_NVAPI = "1";
      PROTON_HIDE_NVIDIA_GPU = "0";
      PROTON_ENABLE_NGX_UPDATER = "1";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
      __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
    };
  };

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
    dconf.enable = true;
    gamemode.enable = true;

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    hyprland = {
      enable = true;
      withUWSM = true;
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

    ssh.startAgent = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    xfconf.enable = true;

    zsh = {
      enable = true;
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

    blueman.enable = true;
    fstrim.enable = true; # ssd optimizer

    goxlr-utility = {
      enable = true;
      autoStart.xdg = true;
    };

    gvfs.enable = true; # allow gtk based file managers to browse samba shares
    libinput.enable = true; # input handler

    mullvad-vpn = {
      enable = true;
      gui.enable = true;
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
      wireplumber.enable = true;
    };

    printing.enable = false;
    pulseaudio.enable = false;

    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };

    tumbler.enable = true; # image/video previewer
    udisks2.enable = true; # USB auto mounting

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
