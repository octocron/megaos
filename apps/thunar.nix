{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
  };

  services.xserver.desktopManager.xfce.enable = false;

  environment = {
    etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita-dark
      gtk-icon-theme-name=Adwaita
      gtk-application-prefer-dark-theme=true
    '';
    systemPackages = with pkgs; [
      xfce.xfconf
      xfce.exo
      gsettings-desktop-schemas
      adwaita-icon-theme
    ];
    variables = {
      GTK_THEME = "Adwaita-dark";
    };
  };
}
