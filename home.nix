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
      ".config/neofetch/config.conf".source = ./config/neofetch/config.conf;
      ".config/starship.toml".source = ./config/starship.toml;
      ".config/wezterm/wezterm.lua".source = ./config/wezterm.lua;

      ".emoji".source = ./config/emoji;

      ".config/vim" = {
        source = ./config/vim;
        recursive = true;
      };
    };
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
