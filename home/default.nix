#----------Home Configurations----------#
{ desktop, ... }:
{
  imports = [
    #./anyrun.nix
    ./fastfetch/fastfetch.nix
    ./rofi
    ./scripts
    ./wleave
    #./wlogout
    ./bat.nix
    ./cava.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./mpd.nix
    ./nixSearchTV.nix
    ./nnn.nix
    #./ollama.nix
    ./opencode.nix
    ./packages.nix
    ./qt.nix
    ./rmpc.nix
    ./sops.nix
    ./ssh.nix
    ./swappy.nix
    ./swaync.nix
    ./thunar.nix
    ./ticker.nix
    ./tmux.nix
    ./udiskie.nix
    ./wezterm.nix
    ./yazi.nix
    ./yt.nix
    ./zathura.nix
    ./zsh.nix
  ]
  ++ (if desktop == "hyprland" then [ ./hyprland ] else [ ])
  ++ (if desktop == "niri" then [ ./niri ] else [ ]);
}
