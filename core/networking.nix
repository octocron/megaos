{
  config,
  hostname,
  options,
  ...
}:
{
  #-----------------NETWORKING------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
    networkmanager = {
      enable = true;
      ensureProfiles.profiles.multiplex = {
        connection = {
          id = "Multiplex";
          type = "wifi";
        };
        ipv4 = {
          method = "auto";
        };
        wireless = {
          ssid = "Multiplex";
          mode = "infrastructure";
        };
        wireless-security = {
          key-mgmt = "wpa-psk";
          psk = config.sops.secrets.passwordMultiplex.path;
        };
      };
    };
    nftables.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    nameservers = [
      "10.99.0.37"
      "192.168.1.37"
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
