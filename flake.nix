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
    {
      darkmatter-grub-theme,
      disko,
      home-manager,
      hyprland,
      megavim,
      nix-minecraft,
      nix-index-database,
      nixpkgs,
      self,
      sops-nix,
      ...
    }@inputs:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86-64-darwin"
        "x86_64-linux"
        "i686-linux"
      ];
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
        inherit systems;
        inherit theTimezone;
        inherit username;
      };
      personalArgs = {
        inherit gitUsername;
        inherit gitEmail;
        inherit inputs;
        inherit systems;
        inherit username;
      };
    in
    {
      nixosConfigurations = {
        galvatron = nixpkgs.lib.nixosSystem {
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/galvatron/configuration.nix
            darkmatter-grub-theme.nixosModule
            disko.nixosModules.disko
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
        energon = nixpkgs.lib.nixosSystem {
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
