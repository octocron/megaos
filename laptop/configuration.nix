{ inputs
, pkgs
, username
, hostname
, gitUsername
, theLocale
, theTimezone
, ...
}:

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

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "${hostname}"; # Define your hostname.

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.cava = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.cava;
    general.frameRate = 60;
    input.method = "alsa";
    smoothing.noise_reduction = 88;
    color = {
      background = "#ee4400";
      foreground = "#228800";
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    libinput.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  sound.enable = true;
  security.rtkit.enable = true;


  system.stateVersion = "23.11";
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
