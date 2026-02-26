{
  lib,
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
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
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra; # NOTE: nightfox-gtk-theme didnt fully work
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
