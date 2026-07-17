{
  hostname,
  options,
  ...
}:
{
  #-----------------NETWORKING------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
    networkmanager.enable = true;
    nftables.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    nameservers = [
      "10.99.0.37"
      "9.9.9.9"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        #11434 # ollama
      ];
      allowedUDPPorts = [
      ];
      trustedInterfaces = [ "nebula.megaport" ];
    };
  };
}
