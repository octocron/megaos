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

    hyprland.url = "github:hyprwm/Hyprland";
    megavim.url = "gitlab:megacron/megavim?ref=nixvim";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

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
      home-manager,
      hyprland,
      megavim,
      nix-minecraft,
      nix-index-database,
      nixpkgs,
      self,
      sops-nix,
      ...
    }:
    let
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
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs;
          modules = [
            ./desktop/configuration.nix
            darkmatter-grub-theme.nixosModule
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = personalArgs;
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
