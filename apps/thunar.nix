{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    xfconf.enable = true;
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
      GTK_THEME = "Adwaita-dark";
      XDG_SESSION_TYPE = "wayland";
      GTK_USE_PORTAL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      TERMINAL = "kitty";
      HOTKEY_OVERLAY = "1";

      # INFO: NVIDIA Gaming Optimizations
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "1";
      PROTON_ENABLE_NVAPI = "1";
      PROTON_HIDE_NVIDIA_GPU = "0";
      PROTON_ENABLE_NGX_UPDATER = "1";
    };
  };
}
