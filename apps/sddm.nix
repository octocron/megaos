# SDDM is a# display manager for X11 and Wayland in place of greetd
{
  pkgs,
  username,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    # astronaut, black_hole, cyberpunk, hyprland_kath, jake_the_dog, pixel_sakura
    embeddedTheme = "cyberpunk";
    themeConfig = {
      #background = "/path/to/your/custom/image.jpg";
      #HeaderTextColor = "#ee4400";
      #DateTextColor = "#ee4400";
      #TimeTextColor = "#ee4400";
      #LoginFieldTextColor = "#ee4400";
      #PasswordFieldTextColor = "#ee4400";
      #UserIconColor = "#ee4400";
      #PasswordIconColor = "#ee4400";
      #WarningColor = "#ee4400";
      #LoginButtonBackgroundColor = "#212121";
      #SystemButtonsIconsColor = "#212121";
      #SessionButtonTextColor = "#ee4400";
      #VirtualKeyboardButtonTextColor = "#ee4400";
      #DropdownBackgroundColor = "#212121";
      #HighlightBackgroundColor = "#ee4400";
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
