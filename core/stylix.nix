# stylix.homeManagerModules.stylix does not work with boot or display manager, so always use nixos when possible
{pkgs, ...}: let
  inherit (import ../home/variables.nix) stylixImage;
in {
  stylix = {
    enable = true;
    image = stylixImage;
    base16Scheme = {
      base00 = "282936"; # default background
      base01 = "3a3c4e"; # alternate background, incomplete progress bar
      base02 = "4d4f68"; # selection background, complete progress bar
      base03 = "626483"; # unfocused window border
      base04 = "62d6e8"; # alternate text
      base05 = "e9e9f4"; # default text, window title text
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2"; # error text, urgent window border
      base09 = "b45bcf"; # urgent text
      base0A = "00f769"; # warning text
      base0B = "ebff87";
      base0C = "a1efe4";
      base0D = "62d6e8"; # focused window border
      base0E = "b45bcf"; # item on background color
      base0F = "00f769";
    };
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
    autoEnable = false;
    targets = {
      waybar.enable = true;
    };
  };
}
