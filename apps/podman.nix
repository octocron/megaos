{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--filter=until=24h"
          "--filter=label!=important"
        ];
      };
      defaultNetwork.settings.dns_enabled = true;
    };

    # INFO: sudo systemctl start podman-windows or stop when done.
    # INFO: http://localhost:8006
    oci-containers = {
      backend = "podman";

      containers.windows = {
        autoStart = false;
        image = "ghcr.io/dockur/windows:latest";

        environment = {
          VERSION = "11";
          RAM_SIZE = "4G";
          CPU_CORES = "2";
          DISK_SIZE = "64G";
        };

        ports = [
          "8006:8006"
        ];

        volumes = [
          "/home/${username}/Documents/windows:/shared"
          "/var/lib/windows:/storage"
        ];

        extraOptions = [
          "--device=/dev/kvm"
        ];
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/windows 0755 root root -"
  ];
}
