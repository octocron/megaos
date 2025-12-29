{ pkgs, ... }:
{
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
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
      configPackages = [ pkgs.niri ]; # TODO: check this
    };
  };
}
