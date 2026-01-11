{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.intel;
in
{
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "i915" ];

    hardware = {
      cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };
  };
}
