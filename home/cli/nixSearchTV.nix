{ config, ... }:
{
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
    settings = {
      indexes = [
        "darwin"
        "home-manager"
        "nixos"
        "nixpkgs"
      ];

      cache_dir = "${config.xdg.cacheHome}/nix-search-tv";
      enable_waiting_message = true;
    };
  };
}
