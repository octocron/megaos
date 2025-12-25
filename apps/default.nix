_: {
  #----------NixOS Configurations------------#
  imports = [
    ./fonts.nix
    ./greetd.nix
    ./minecraft.nix
    ./podman.nix
    ./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
