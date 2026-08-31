{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/
        device = "/dev/disk/by-id/nvme-SERIAL_1";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            zfs = {
              size = "100%";

              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };

      nvme1 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/
        device = "/dev/disk/by-id/nvme-SERIAL_2";

        content = {
          type = "gpt";

          partitions = {
            zfs = {
              size = "100%";

              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };

      nvme2 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/
        device = "/dev/disk/by-id/nvme-SERIAL_3";

        content = {
          type = "gpt";

          partitions = {
            zfs = {
              size = "100%";

              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
    };

    zpool = {
      tank = {
        type = "zpool";
        mountpoint = "/";
        mode = {
          topology = {
            type = "topology";

            vdev = [
              {
                mode = "raidz1";

                members = [
                  "nvme0"
                  "nvme1"
                  "nvme2"
                ];
              }
            ];
          };
        };

        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          compression = "zstd";
          recordsize = "128K";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
        };
      };
    };
  };
}
