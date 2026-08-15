{
  lib,
  pkgs,
  ...
}:
{
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
    theme = lib.mkForce {
      name = "Nightfox-dark"; # Adwaita-dark
      package = pkgs.nightfox-gtk-theme; # NOTE: nightfox-gtk-theme didnt fully work | gnome-themes-extra
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
