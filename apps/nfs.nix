{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.nfs;
in
{
  options.services.nfs.enable = mkEnableOption "enable nfs";

  config = mkIf cfg.enable {
  };
}
