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

    nox = {
      url = "github:madsbv/nix-options-search";
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
      nox,
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
        # INFO: Gaming Rig
        energon = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "energon";
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
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username}.imports = [
                  ./home.nix
                  ./home/gui
                  ./home/wm/hyprland
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
          ];
        };

        # INFO: Test Gaming Rig
        galvatron = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "galvatron";
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
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${username}.imports = [
                  ./home.nix
                  ./home/gui
                  ./home/wm/hyprland
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
          ];
        };

        # INFO: NixOS Server
        ironhide = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "ironhide";
          };
          modules = [
            ./hosts/ironhide/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = personalArgs // {
                  hostname = "ironhide";
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

        # INFO: DigitalOcean VPS
        # INFO: nix build .#nixosConfigurations.scorponok.config.system.build.digitalOceanImage
        # INFO: Rebuilds: nixos-rebuild switch --flake .#scorponok --target-host root@<scorponok-ip>
        scorponok = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs // {
            hostname = "scorponok";
          };

          modules = [
            ./hosts/scorponok/configuration.nix

            # NOTE: DigitalOcean image + runtime configuration
            "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"

            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops

            {
              home-manager = {
                extraSpecialArgs = personalArgs // {
                  hostname = "scorponok";
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
