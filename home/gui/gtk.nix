{ pkgs, ... }: {
  gtk = {
    enable = true;
    colorScheme = "dark";
    font = {
      name = "Maple Mono";
      size = 12;
      package = pkgs.maple-mono.opentype;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "Dracula";
  };

  home.sessionVariables = {
    GTK_THEME = "Dracula";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
