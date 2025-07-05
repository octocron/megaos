_: let
  inherit (import ./variables.nix) waybarChoice;
in {
  #----------Home Configurations----------#
  imports = [
    ./fastfetch/fastfetch.nix
    ./hyprland
    ./rofi
    ./scripts
    ./cava.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./nnn.nix
    ./packages.nix
    ./qt.nix
    ./swappy.nix
    ./swaync.nix
    ./tmux.nix
    waybarChoice
    ./xdg.nix
    ./yazi.nix
    ./zsh.nix
  ];
}
