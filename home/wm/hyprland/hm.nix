{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      # NOTE: unmodified graphical apps
      audacity
      brave
      discord
      davinci-resolve
      gimp
      mpv
      #modrinth-app
      mullvad-vpn
      nodejs
      obs-studio
      plexamp
      prismlauncher
      signal-desktop
      spotify
      supertuxkart
      xonotic
      wezterm

      # NOTE: graphical cli tools
      hyprland-qtutils # needed for banners and ANR messages
      hyprpicker # JS: popup picker
      hyprpolkitagent
      rofi
      rofi-emoji # C: emoji plugin for rofi
      slurp
      swappy
      swaynotificationcenter
      awww
      symbola

      #(import ./lsbind.nix { inherit pkgs; })
    ];

    file = {
      ".config/wezterm/wezterm.lua".source = ../../gui/wezterm.lua;
      ".face.icon".source = ./face.png;
      ".config/face.png".source = ./face.png;

      "Pictures/Wallpapers" = {
        source = ../../../media/wallpapers;
        recursive = true;
      };
    };

    sessionVariables = {
      TERMINAL = "wezterm";
      XDG_TERMINAL_EMULATOR = "wezterm";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };
  };

  services = {
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
