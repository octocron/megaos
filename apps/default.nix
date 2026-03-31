_: {
  #----------NixOS Configurations------------#
  imports = [
    ./hyprland.nix
    ./minecraft.nix
    #./nebula.nix
    ./nfs.nix
    ./niri.nix
    ./podman.nix
    ./samba.nix
    #./satisfactory.nix
    ./sddm.nix
    ./sops.nix
    ./tailscale.nix
  ];
}
