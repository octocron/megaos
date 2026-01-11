{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.nvidiaPrime;
in
{
  #---------------Nvidia-Prime-Support--------------------------------#
  options.drivers.nvidiaPrime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
    intelBusID = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
    };
    nvidiaBusID = mkOption {
      type = types.str;
      default = "PCI:0:2:0";
    };
  };
  config = mkIf cfg.enable {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # NOTE: 'lspci | rg VGA' to find GPU IDs
        intelBusId = "${cfg.intelBusID}";
        nvidiaBusId = "${cfg.nvidiaBusID}";
      };
    };
  };
}
