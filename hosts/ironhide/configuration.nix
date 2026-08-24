{
  pkgs,
  username,
  ...
}:
{
  system.stateVersion = "26.05";
  #----------------------NixOS-MODULES-----------------#
  imports = [
    ./hardware-configuration.nix
    ./nebula.nix

    ../../apps/sops.nix

    ../../containers/podman.nix
    ../../containers/samba.nix

    ../../boot/limine.nix
    ../../core
    ../../drivers
    ../../users/megacron.nix
  ];

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
      steamcmd
    ];

    sessionVariables = {
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
      enable32Bit = false;
    };

    enableRedistributableFirmware = true;
  };

  #-----------------------PROGRAMS-----------------------#
  programs = {
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

    fstrim.enable = true; # ssd optimizer

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no"; # prevent root from SSH login
        PasswordAuthentication = true; # users can SSH using username and password
        KbdInteractiveAuthentication = true; # allow keyboard based auth
      };
    };

    # steam-servers = {
    #   satisfactory = {
    #     enable = true;
    #     autoStart = false;
    #     experimental = false;
    #     installDir = "/var/lib/satisfactory";
    #     openFirewall = false; # false when using nebula
    #   };
    # };

    printing.enable = false;
    pulseaudio.enable = false;

    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
  };
}
