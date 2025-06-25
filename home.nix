{
  pkgs,
  username,
  ...
}: {
  home = {
    # Home Manager Settings
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
    file = {
      # Place Files Inside Home Directory
      ".config/pipewire/pipewire.conf".source = ./config/pipewire/pipewire.conf;
      ".config/neofetch/config.conf".source = ./config/neofetch/config.conf;
      ".config/starship.toml".source = ./config/starship.toml;
      ".config/wezterm/wezterm.lua".source = ./config/wezterm.lua;

      ".emoji".source = ./config/emoji;
      ".face".source = ./config/face.png;

      ".local/share/fonts" = {
        source = ./fonts;
        recursive = true;
      };
      ".config/hypr" = {
        source = ./config/hyprland;
        recursive = true;
      };
      ".config/rofi" = {
        source = ./config/rofi;
        recursive = true;
      };
      ".config/swaync" = {
        source = ./config/swaync;
        recursive = true;
      };
      ".config/vim" = {
        source = ./config/vim;
        recursive = true;
      };
      "Pictures/wallpapers" = {
        source = ./media/wallpapers;
        recursive = true;
      };
    };

    # Install Packages For The User
    packages = with pkgs; [
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
      (import ./scripts/emopicker9000.nix {inherit pkgs;})
      (import ./scripts/task-waybar.nix {inherit pkgs;})
      (import ./scripts/squirtle.nix {inherit pkgs;})
      (import ./scripts/wallsetter.nix {inherit pkgs;})
    ];
  };

  # Builtin Programs
  programs = {
    home-manager.enable = true;
    cava.enable = true;
    command-not-found.enable = true;
    jq.enable = true;
    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = true;
        };
      };
    };
  };

  # Module imports
  imports = [
    ./app/theme.nix
    ./app/waybar.nix
    ./shell/cava.nix
    ./shell/git.nix
    ./shell/kitty.nix
    ./shell/packages.nix
    ./shell/tmux.nix
    ./shell/zsh.nix
  ];

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
      "*.{js,py}" = {
        indent_size = 4;
      };
    };
  };
}
