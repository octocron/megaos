_: {
  #----------NixOS Configurations------------#
  imports = [
    ./minecraft.nix
    ./podman.nix
    ./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
