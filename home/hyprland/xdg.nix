{ pkgs, ... }:
{
  # NOTE: dconf read /org/gnome/desktop/interface/color-scheme
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
      config.common = {
        default = [
          "gnome"
          "gtk"
          "hyprland"
        ];
        "org.freedesktop.impl.portal.Settings" = "gnome";
      };
    };
  };
}
