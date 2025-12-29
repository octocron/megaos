{ pkgs, ... }:
{
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
}
