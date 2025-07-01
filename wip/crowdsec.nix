{ hostname, ... }:

{
  inputs = {
    crowdsec = {
      url = "github:kampka/nix-flake-crowdsec";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    flakes @ { self
    , nixpkgs
    , crowdsec
    , hostname
    , ...
    }: {
      nixosConfiguration.${hostname} = nixpkgs.lib.nixosSystem {
        # ...
        modules = [
          # ...
          crowdsec.nixosModules.crowdsec

          ({ pkgs, lib, ... }: {
            services.crowdsec = {
              enable = true;
              enrollKeyFile = "/path/to/enroll-key";
              settings = {
                api.server = {
                  listen_uri = "127.0.0.1:8080";
                };
              };
            };
          })

          crowdsec.nixosModules.crowdsec-firewall-bouncer

          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [ crowdsec.overlays.default ];
            services.crowdsec-firewall-bouncer = {
              enable = true;
              settings = {
                api_key = "<api-key>";
                api_url = "http://localhost:8080";
              };
            };
          })
        ];
      };
    };
}

