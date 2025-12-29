#----------Home Configurations----------#
{ desktop, ... }:
{
  imports = [
    #./anyrun.nix
    ./fastfetch/fastfetch.nix
    ./rofi
    ./scripts
    ./cava.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./nnn.nix
    ./packages.nix
    ./qt.nix
    ./sops.nix
    ./swappy.nix
    ./swaync.nix
    ./tmux.nix
    ./waybar.nix
    ./wlogout
    ./xdg.nix
    ./yazi.nix
    ./zsh.nix
  ]
  ++ (if desktop == "hyprland" then [ ./hyprland ] else [ ])
  ++ (if desktop == "niri" then [ ./niri ] else [ ]);
}
