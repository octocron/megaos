{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;
  systemd.tmpfiles.rules = [
    "d /mnt/satisfactory-plus 0755 root root -"
  ];
  fileSystems."/mnt/satisfactory-plus" = {
    device = "192.168.1.99:/var/lib/satisfactory-plus";
    fsType = "nfs4";
    options = [
      "hard"
      "nfsvers=4.2"
      "_netdev"
      "noatime"
      "nconnect=4"
      "rsize=1048576"
      "wsize=1048576"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };
}
