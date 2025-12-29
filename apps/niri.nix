{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.niri;
in
{
  options.services.niri.enable = mkEnableOption "enable niri";

  config = mkIf cfg.enable {
    # TODO: Add niri configuration here once niri is available in nixpkgs or as an input
    # programs.niri = {
    #   enable = true;
    # };
  };
}