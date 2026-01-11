{
  description = "megaOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    megavim.url = "gitlab:megacron/megavim?ref=nixvim";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    noctalia.url = "github:noctalia-dev/noctalia-shell";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      darkmatter-grub-theme,
      disko,
      home-manager,
      hyprland,
      megavim,
      nix-minecraft,
      nix-index-database,
      nixpkgs,
      noctalia,
      self,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "megacron";
      gitUsername = "megacron";
      gitEmail = "megacron@d3c3p7.com";
      theLocale = "en_US.UTF-8";
      theTimezone = "America/New_York";
      commonSpecialArgs = {
        inherit gitEmail;
        inherit gitUsername;
        inherit inputs;
        inherit theLocale;
        inherit system;
        inherit theTimezone;
        inherit username;
      };
      personalArgs = {
        inherit gitUsername;
        inherit gitEmail;
        inherit inputs;
        inherit system;
        inherit username;
      };
    in
    {
      nixosConfigurations = {
        galvatron = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "galvatron";
            desktop = "hyprland";
          };
          modules = [
            ./hosts/galvatron/configuration.nix
            darkmatter-grub-theme.nixosModule
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = personalArgs // {
                  hostname = "galvatron";
                  desktop = "hyprland";
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${username}.imports = [
                  ./home.nix
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
          ];
        };
        energon = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "energon";
            desktop = "hyprland";
          };
          modules = [
            ./hosts/energon/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = personalArgs // {
                  hostname = "energon";
                  desktop = "hyprland";
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username}.imports = [
                  ./home.nix
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
          ];
        };
      };
    };
}
