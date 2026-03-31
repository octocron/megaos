#----------Home Configurations----------#
{ ... }:
{
  imports = [
    #./anyrun.nix
    ./fastfetch/fastfetch.nix
    ./rofi
    ./scripts
    ./cava.nix
    ./git.nix
    ./gtk.nix
    ./hyprland
    ./kitty.nix
    ./nnn.nix
    #./ollama.nix
    ./opencode.nix
    ./packages.nix
    ./qt.nix
    ./sops.nix
    ./ssh.nix
    ./swappy.nix
    ./swaync.nix
    ./thunar.nix
    ./tmux.nix
    ./udiskie.nix
    ./wezterm.nix
    ./wlogout
    ./yazi.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
