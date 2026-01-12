{ hostname, ... }:
let
  inherit (import ../variables.nix) animChoice;
in
{
  #----------Hyprland Configurations----------#
  imports = [
    animChoice
    ./env.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    #./hyprpanel.nix
    ./hyprpaper.nix
    ./keybinds.nix
    #./pyprland.nix
    ./waybar.nix
    ./windowrules.nix
    ./xdg.nix
  ];
}
