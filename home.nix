{
  pkgs,
  username,
  ...
}: {
  #----------------Home Manager-----------------------------#
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
    file = {
      # Place Files Inside Home Directory
      ".config/neofetch/config.conf".source = ./home/neofetch/config.conf;
      #".config/starship.toml".source = ./home/starship.toml;
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
    packages = with pkgs; [
      grim
      hyprland-qtutils # needed for banners and ANR messages
      hyprpolkitagent
      slurp
      swappy
      swww
      wl-clipboard
      ydotool
    ];
  };

  #-----------------Home-Modules-----------------------------#
  imports = [
    ./home
  ];

  #-----------------Builtin Programs-------------------------#
  programs = {
    home-manager.enable = true;
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
}
