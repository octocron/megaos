_: {
  #----------NixOS Configurations------------#
  imports = [
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
