{
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
      "async"
      "hard"
      "intr"
      "_netdev"
      "nfsvers=4.1"
      "noatime"
      "retrans=5"
      "rw"
      "timeo=900"
      "rsize=1048576"
      "wsize=1048576"
    ];
  };
}
