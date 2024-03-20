{ pkgs, username, ... }:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Module imports
  imports = [
    ./app/theme.nix
    ./app/waybar.nix
#./shell/cava.nix
    ./shell/git.nix
    ./shell/kitty.nix
    ./shell/nixvim.nix
    ./shell/packages.nix
    ./shell/tmux.nix
    ./shell/zsh.nix
  ];

  # Place Files Inside Home Directory
  home.file.".config/pipewire/pipewire.conf".source = ./config/pipewire/pipewire.conf;
  home.file.".config/neofetch/config.conf".source = ./config/neofetch/config.conf;
  home.file.".config/starship.toml".source = ./config/starship.toml;
  home.file.".emoji".source = ./config/emoji;
  home.file.".face".source = ./config/face.png;
  home.file.".vimrc".source = ./config/vimrc;
  home.file.".config/wezterm/wezterm.lua".source = ./config/wezterm.lua;
  home.file."Pictures/wallpapers" = {
    source = ./media/wallpapers;
    recursive = true;
  };
  home.file.".local/share/fonts" = {
    source = ./fonts;
    recursive = true;
  };
  home.file.".config/rofi" = {
    source = ./config/rofi;
    recursive = true;
  };
  home.file.".config/swaync" = {
    source = ./config/swaync;
    recursive = true;
  };
  home.file.".config/hypr" = {
    source = ./config/hyprland;
    recursive = true;
  };

  # editorconfig
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 2;
        end_of_line = "lf";
        charset = "utf-8";
      };
    };
  };


  # Install Packages For The User
  home.packages = with pkgs; [
    font-awesome
    gnome.file-roller
    libnotify
    lm_sensors
    material-icons
    meson
    ninja
    noto-fonts-color-emoji
    pavucontrol
    pkg-config
    polkit_gnome
    rofi-wayland
    socat
    swaynotificationcenter
    symbola
    swww
    transmission-gtk
    v4l-utils
    wl-clipboard
    ydotool
    zeroad

    # Import Scripts
    (import ./scripts/emopicker9000.nix { inherit pkgs; })
    (import ./scripts/task-waybar.nix { inherit pkgs; })
    (import ./scripts/squirtle.nix { inherit pkgs; })
    (import ./scripts/wallsetter.nix { inherit pkgs; })
  ];

  programs.home-manager.enable = true;
  programs.cava.enable = true;
  programs.command-not-found.enable = true;
  programs.jq.enable = true;
  programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };
}
