# INFO: nix flake check
{ self, ... }:
{
  flake = {
    checks = {
      x86_64-linux = {
        #energon = self.nixosConfigurations.energon.system;
        galvatron = self.nixosConfigurations.galvatron.system;
      };
    };
  };
}
