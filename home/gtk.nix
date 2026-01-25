{ pkgs, ... }:
{
  gtk = {
    font = {
      name = "Maple Mono";
      size = 12;
      package = pkgs.maple-mono.opentype;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
