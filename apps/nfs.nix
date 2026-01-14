{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.nfs;
in
{
  options.services.nfs.enable = mkEnableOption "enable nfs";

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "nfs" ];
    services.rpcbind.enable = true;

    systemd.tmpfiles.rules = [
      "d /mnt/steam 0755 root root -"
    ];

    fileSystems."/mnt/steam" = {
      enable = true;
      noCheck = true;
      device = "192.168.1.87:/volume1/steam";
      fsType = "nfs";
      options = [
        "_netdev"
        "nfsvers=4.2"
        "noatime"
        "noauto"
        "rw"
        "soft"
        "timeo=150"
        "x-systemd.automount"
      ];
    };
  };
}
