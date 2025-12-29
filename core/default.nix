_: {
  #----------NixOS Core------------#
  imports = [
    ./env.nix
    ./fonts.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./systemd.nix
  ];
}
