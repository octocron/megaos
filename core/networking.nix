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
    firewall = {
      enable = true;
      allowedTCPPorts = [
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
}
