{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/
        device = "/dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202954P";

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
        device = "/dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202994E";

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
        device = "/dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L203102B";

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

      vault0 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/ | grep -E 'ata-|wwn-'
        device = "/dev/disk/by-id/ata-ST12000VN0008-2PH103_ZTN1D2MF";
        content = {
          type = "gpt";

          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "vault";
              };
            };
          };
        };
      };

      vault1 = {
        type = "disk";
        # NOTE: ls -l /dev/disk/by-id/ | grep -E 'ata-|wwn-'
        device = "/dev/disk/by-id/ata-ST12000VN0008-2PH103_ZTN19ERQ";
        content = {
          type = "gpt";

          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "vault";
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

      vault = {
        type = "zpool";
        mode = {
          topology = {
            type = "topology";
            vdev = [
              {
                mode = "mirror";
                members = [
                  "vault0"
                  "vault1"
                ];
              }
            ];
          };
        };

        options = {
          ashift = "12";
        };

        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          recordsize = "1M";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
        };
      };
    };
  };
}
