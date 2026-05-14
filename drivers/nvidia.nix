{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.nvidia;
in
{
  # NOTE: nvidia-smi
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };
  config = mkIf cfg.enable {
    hardware.nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false; # For 5000+ series
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable; # INFO: [ latest || stable]
    };
  };
}
