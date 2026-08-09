# NOTE: SDDM is a display manager for X11 and Wayland in place of greetd
{
  pkgs,
  username,
  ...
}:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    # INFO: astronaut, black_hole, cyberpunk, hyprland_kath, jake_the_dog, pixel_sakura
    embeddedTheme = "cyberpunk";
  };
in
{
  environment.systemPackages = [ sddm-astronaut ];
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "${username}";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = [
        sddm-astronaut
        pkgs.kdePackages.qtmultimedia
      ];
    };
  };
}
