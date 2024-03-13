{ inputs, pkgs, username, hostname, gitUsername, theLocale, theTimezone, ...}:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader choose either systemd (modern) or grub (legacy)
  boot.loader.grub = {
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
  boot.loader.timeout = 30;

  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "${hostname}"; # Define your hostname.
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${theLocale}";

  i18n.extraLocaleSettings = {
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

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    homeMode = "755";
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCFpd0UZyX1T0WewVnzEWYY+9oXX+JcJaTLusO33/FX ansible"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHPOPzh8vu5f8/T5IbbD6/1tzpnH94EPcta7FS2vUy45 optimus"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1ZJSRTAzfmHNMDLWHKEm1oCr82v8zYvoaMVAvIGZdp galvatron"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYwMb4RRHkA0WL+TF9XtW54hqu4XrY2yLsF7b+9PCdY blackout.local"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPnQdwT0HIgx43nv37wrepEAn6BDeP0uxLT/KDKAHE/ energon"
    ];
  };

  # Fonts (systemwide)
  fonts.packages = with pkgs; [
    nerdfonts
    maple-mono-NF
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (pkgs.nnn.override { withNerdIcons = true; })
    curl
    git
    parted
    polychromatic
    vim
    wget
    zsh
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.thunar.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
  };

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "$username" ];

  # security
  security.rtkit.enable = true;
  security.sudo.extraConfig = ''
    Defaults      timestamp_timeout=1800
  '';

  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput.enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
      autoLogin.enable = true;
      autoLogin.user = "${username}";
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.samba = {
    enable = true;
    client = true;
  };

  system.stateVersion = "23.11";
  nix = {
    settings = {
      log-lines = 50;
      warn-dirty = false;
      trusted-users = [ "$username" ];
      allowed-users = [ "$username" ];
      http-connections = 50;
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Set Environment Variables
  environment.variables = {
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
}
