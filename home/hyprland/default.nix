_: let
  inherit (import ../variables.nix) animChoice;
in {
  #----------Hyprland Configurations----------#
  imports = [
    animChoice
    ./env.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./keybinds.nix
    ./pyprland.nix
    ./windowrules.nix
  ];
}
