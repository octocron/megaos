{ pkgs, ... }:
{
  home.packages = [
    (import ./emopicker9000.nix { inherit pkgs; })
    (import ./hmfind.nix { inherit pkgs; })
    (import ./lsbind.nix { inherit pkgs; })
    (import ./rofi-launcher.nix { inherit pkgs; })
    (import ./screenshootin.nix { inherit pkgs; })
    (import ./squirtle.nix { inherit pkgs; })
    (import ./task-waybar.nix { inherit pkgs; })
    (import ./websearch.nix { inherit pkgs; })
  ];
}
