_: {
  #----------NixOS Configurations------------#
  imports = [
    ./fonts.nix
    ./minecraft.nix
    ./podman.nix
    ./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
