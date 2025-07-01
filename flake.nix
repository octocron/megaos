{
  description = "megaOS";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = inputs @ {
    darkmatter-grub-theme,
    home-manager,
    hyprland,
    nix-minecraft,
    nixpkgs,
    self,
    stable,
    ...
  }: let
    system = "x86_64-linux";
    hostname = "galvatron";
    username = "megacron";
    gitUsername = "megacron";
    gitEmail = "megacron@d3c3p7.com";
    theLocale = "en_US.UTF-8";
    theTimezone = "America/New_York";
    commonSpecialArgs = {
      inherit gitEmail;
      inherit gitUsername;
      inherit hostname;
      inherit inputs;
      inherit system;
      inherit theLocale;
      inherit theTimezone;
      inherit username;
    };
    personalArgs = {
      inherit username;
      inherit gitUsername;
      inherit gitEmail;
    };
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = [
          ./desktop/configuration.nix
          darkmatter-grub-theme.nixosModule
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = personalArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix;
            };
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = [
          ./laptop/configuration.nix
          darkmatter-grub-theme.nixosModule
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = personalArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
