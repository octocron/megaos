{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  services.xserver.desktopManager.xfce.enable = false;

  environment = {
    systemPackages = with pkgs; [
      xfconf
      xfce4-exo
      gsettings-desktop-schemas
      adwaita-icon-theme
    ];
    variables = {
    };
  };
}
