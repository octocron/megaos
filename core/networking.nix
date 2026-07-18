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
    nftables.enable = true;
    networkmanager = {
      enable = true;
      ensureProfiles.profiles.multiplex = {
        connection = {
          id = "Multiplex";
          type = "wifi";
        };
        ipv4 = {
          method = "auto";
          ignore-auto-dns = true;
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

    nameservers = [
      "192.168.1.37"
    ];

    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

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
