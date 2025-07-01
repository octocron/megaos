_: let
  inherit (import ./variables.nix) waybarChoice;
in {
  #----------Home Configurations----------#
  imports = [
    ./fastfetch
    ./hyprland
    ./rofi
    ./scripts
    ./cava.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./packages.nix
    ./qt.nix
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./tmux.nix
    waybarChoice
    ./xdg.nix
    ./zsh.nix
  ];
}
