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
    services.rpcbind.enable = true;

    systemd.tmpfiles.rules = [
      "d /mnt/steam 0755 root root -"
    ];

    fileSystems."/mnt/steam" = {
      enable = true;
      noCheck = true;
      label = "steam";
      device = "192.168.1.87:/volume1/steam";
      fsType = "nfs";
      options = [
        "nfsvers=4.1"
        "rw"
        "retrans=3"
        "soft"
        "_netdev"
        "noatime"
        "timeo=10"
      ];
    };
  };
}
