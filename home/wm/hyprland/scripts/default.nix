{ pkgs, ... }: {
  home.packages = [
    (import ./rofi-launcher.nix { inherit pkgs; })
    (import ./screenshootin.nix { inherit pkgs; })
    (import ./task-waybar.nix { inherit pkgs; })
  ];
}
