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
