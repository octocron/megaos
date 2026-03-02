{
  config,
  hostname,
  lib,
  options,
  ...
}:
{
  #-----------------NETWORKING------------------------#
  networking = {
    hostName = "${hostname}"; # Defines hostname.
    networkmanager.enable = true;
    nftables.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    wireless.enable = lib.mkForce false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        11434
      ];
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      trustedInterfaces = [ "tailscale0" ];
    };
    #proxy = {
    #  default = "http://user:password@proxy:port/";
    #  noProxy = "127.0.0.1,localhost,internal.domain";
    #};
  };

  services = {
    # needed for mullvad
    resolved = {
      enable = true;
      dnssec = "true"; # NOTE: [ allow-downgrade false true ]
      dnsovertls = "true"; # NOTE: [ opportunistic false true ]
      domains = [ "~." ];
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };
}
