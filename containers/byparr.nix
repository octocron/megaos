{
  virtualisation.oci-containers.containers.byparr = {
    autoStart = true;
    image = "ghcr.io/thephaseless/byparr:latest";
    environment = {
      TZ = "America/New_York";
      # Leave PORT unset = 8191 (FlareSolverr-compatible default)
    };
    ports = [ "127.0.0.1:8191:8191" ];
    # Camoufox (Byparr's browser) needs real /dev/shm — podman default is too small
    extraOptions = [ "--shm-size=1gb" ];
  };
}
