{
  config,
  pkgs,
  ...
}:
{
  programs.nix-search-tv = {
    enable = true;
    settings = {
      indexes = {
        nixpkgs = {
          type = "nixpkgs";
          channel = "nixpkgs";
        };

        home-manager = {
          type = "flake";
          flake = "github:nix-community/home-manager";
        };

        nixos = {
          type = "flake";
          flake = "github:NixOS/nixpkgs/nixos-unstable";
        };

        darwin = {
          type = "flake";
          flake = "github:LnL7/nix-darwin";
        };
      };

      cache_dir = "${config.xdg.cacheHome}/nix-search-tv";
      enable_waiting_message = true;
    };
  };
}
