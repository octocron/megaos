{
  description = "megaOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-23.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, darkmatter-grub-theme, hyprland, ... }:
    let
      system = "x86_64-linux";
      hostname = "galvatron";
      username = "megacron";
      gitUsername = "megacron";
      gitEmail = "megacron@d3c3p7.com";
      theLocale = "en_US.UTF-8";
      theTimezone = "America/New_York";
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system; inherit inputs;
            inherit username; inherit hostname; inherit gitUsername;
            inherit gitEmail; inherit theLocale; inherit theTimezone;
          };
          modules = [
            ./desktop/configuration.nix
            darkmatter-grub-theme.nixosModule
            home-manager.nixosModules.home-manager
            nixvim.homeManagerModules.nixvim
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit gitUsername; inherit gitEmail;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home.nix;
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system; inherit inputs;
            inherit username; inherit hostname; inherit gitUsername;
            inherit gitEmail; inherit theLocale; inherit theTimezone;
          };
          modules = [
            ./laptop/configuration.nix
            darkmatter-grub-theme.nixosModule
            home-manager.nixosModules.home-manager
            nixvim.homeManagerModules.nixvim
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit gitUsername; inherit gitEmail;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home.nix;
            }
          ];
        };
      };
    };
}
