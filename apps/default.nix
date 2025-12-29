_: {
  #----------NixOS Configurations------------#
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./minecraft.nix
    ./niri.nix
    ./podman.nix
    ./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
