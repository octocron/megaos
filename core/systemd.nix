_: {
  #-----------------------SYSTEMD----------------------------#
  systemd = {
    # INFO: give more time for services to shutdown gracefully
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
    services = {
      # INFO: optimise nix builders (keep from running out of memory)
      nix-daemon.serviceConfig = {
        MemoryAccounting = true;
        MemoryMax = "90%";
        OOMScoreAdjust = 500;
      };
    };
  };
}
