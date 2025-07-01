# SDDM is a display manager for X11 and Wayland
{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  foreground = config.stylix.base16Scheme.base00;
  textColor = config.stylix.base16Scheme.base05;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    # astronaut, black_hole, cyberpunk, hyprland_kath, jake_the_dog, pixel_sakura
    embeddedTheme = "cyberpunk";
    themeConfig =
      if lib.hasSuffix "cyberpunk.png" config.stylix.image
      then {}
      else if lib.hasSuffix "studio.png" config.stylix.image
      then {
        Background = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/anotherhadi/nixy-wallpapers/refs/heads/main/wallpapers/studio.gif";
          sha256 = "sha256-qySDskjmFYt+ncslpbz0BfXiWm4hmFf5GPWF2NlTVB8=";
        };
        HeaderTextColor = "#${textColor}";
        DateTextColor = "#${textColor}";
        TimeTextColor = "#${textColor}";
        LoginFieldTextColor = "#${textColor}";
        PasswordFieldTextColor = "#${textColor}";
        UserIconColor = "#${textColor}";
        PasswordIconColor = "#${textColor}";
        WarningColor = "#${textColor}";
        LoginButtonBackgroundColor = "#${foreground}";
        SystemButtonsIconsColor = "#${foreground}";
        SessionButtonTextColor = "#${textColor}";
        VirtualKeyboardButtonTextColor = "#${textColor}";
        DropdownBackgroundColor = "#${foreground}";
        HighlightBackgroundColor = "#${textColor}";
      }
      else {
        Background = "${toString config.stylix.image}";
        HeaderTextColor = "#${textColor}";
        DateTextColor = "#${textColor}";
        TimeTextColor = "#${textColor}";
        LoginFieldTextColor = "#${foreground}";
        PasswordFieldTextColor = "#${foreground}";
        UserIconColor = "#${foreground}";
        PasswordIconColor = "#${foreground}";
        WarningColor = "#${foreground}";
        LoginButtonBackgroundColor = "#${foreground}";
        SystemButtonsIconsColor = "#${foreground}";
        SessionButtonTextColor = "#${textColor}";
        VirtualKeyboardButtonTextColor = "#${textColor}";
        DropdownBackgroundColor = "#${foreground}";
        HighlightBackgroundColor = "#${textColor}";
      };
  };
in {
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "${username}";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = [sddm-astronaut];
      theme = "sddm-astronaut-theme";
    };
  };
}
