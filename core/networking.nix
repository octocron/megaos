{
  hostname,
  options,
  ...
}:
{
  #-----------------NETWORKING------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
    useNetworkd = true;
    nftables.enable = true;
    wireless = {
      iwd = {
        enable = false;
        settings = {
          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
          Settings.AutoConnect = true;
        };
      };
    };

    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        #11434 # ollama
      ];

      allowedUDPPorts = [
      ];

      # interfaces.end0.allowedTCPPorts = [
      #   22 # ssh
      # ];

      trustedInterfaces = [
        "nebula.megaport"
      ];
    };
  };
}
