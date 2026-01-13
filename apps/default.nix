_: {
  #----------NixOS Configurations------------#
  imports = [
    ./hyprland.nix
    ./minecraft.nix
    ./niri.nix
    ./nfs.nix
    ./podman.nix
    #./samba.nix
    ./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
