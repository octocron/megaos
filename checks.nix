# INFO: nix flake check
{ self, ... }:
{
  flake = {
    checks = {
      x86_64-linux = builtins.mapAttrs (name: config: config.system) self.nixosConfigurations;
    };
  };
}
