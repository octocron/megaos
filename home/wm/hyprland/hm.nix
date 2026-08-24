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
      plex-desktop
      plexamp
      prismlauncher
      signal-desktop
      spotify
      supertuxkart
      transmission_4-gtk
      xonotic
      wezterm

      # NOTE: graphical cli tools
      hyprland-qtutils
      hyprpicker # JS: popup picker
      hyprpolkitagent
      rofi
      rofi-emoji # C: emoji plugin for rofi
      slurp
      swappy
      swaynotificationcenter
      symbola
      ydotool
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
      GTK_THEME = "Adwaita-dark";
    };
  };

  services = {
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
