{
  config,
  username,
  ...
}:
{
  #----------------Home Manager-----------------------------#
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
    };
    stateVersion = "23.11";
    file = {
      # Place Files Inside Home Directory
      ".config/starship.toml".source = ./home/starship.toml;
      ".config/wezterm/wezterm.lua".source = ./home/wezterm.lua;

      "Pictures/Wallpapers" = {
        source = ./media/wallpapers;
        recursive = true;
      };
      ".face.icon".source = ./home/hyprland/face.png;
      ".config/face.png".source = ./home/hyprland/face.png;
      ".emoji".source = ./home/emoji;

      ".config/vim" = {
        source = ./home/vim;
        recursive = true;
      };
    };
  };

  #-----------------Home-Modules-----------------------------#
  imports = [
    ./home
  ];

  services = {
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };

  #-----------------Builtin Programs-------------------------#
  programs = {
    home-manager.enable = true;

    command-not-found.enable = false; # mutex to nix-index (using ShellInit script in zsh.nix)
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

  #----------------Editor Config-----------------------------#
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 2;
        end_of_line = "lf";
        charset = "utf-8";
      };
      "*.{js,py,rs}" = {
        indent_size = 4;
      };
      "*.md" = {
        trim_trailing_whitepace = false;
      };
      "*.nix" = {
        trim_trailing_whitespace = true;
      };
    };
  };

  #----------------dconf Config-----------------------------#
  # dconf = {
  #   settings = {
  #     "org.gnome.desktop.interface" = {
  #       color-scheme = "prefer-dark";
  #     };
  #   };
  # };
}
