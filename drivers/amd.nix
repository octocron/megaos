{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.amd;
in
{
  options.drivers.amd = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware = {
      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
      };
    };

    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  };
}
