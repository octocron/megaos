{
  systemd.tmpfiles.rules = [
    "d /vault/metube 0755 1000 1000 -"
  ];

  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers.metube = {
        autoStart = true;
        image = "ghcr.io/alexta69/metube:latest";

        environment = {
          PUID = "1000";
          PGID = "1000";
          UMASK = "022";
          DOWNLOAD_DIR = "/downloads";
          STATE_DIR = "/downloads/.metube";
          TEMP_DIR = "/downloads";
          HOST = "0.0.0.0";
          PORT = "8081";
          URL_PREFIX = "/";
        };

        ports = [ "127.0.0.1:8081:8081" ];

        volumes = [
          "/vault/metube:/downloads"
        ];
      };
    };
  };
}
