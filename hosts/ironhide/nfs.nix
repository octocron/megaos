{ config, ... }:
let
  steamGid = toString config.users.groups.steam.gid;
  steamUid = toString config.users.users.steam.uid;
  plusFlags = [
    "all_squash"
    "anongid=${steamGid}"
    "anonuid=${steamUid}"
    "no_subtree_check"
    "rw"
    "sync"
  ];
in
{
  services.rpcbind.enable = true;
  services.nfs = {
    settings.nfsd = {
      udp = false;
      vers3 = false;
      vers4 = true;
      "vers4.0" = false;
      "vers4.1" = false;
      "vers4.2" = true;
    };
    server = {
      enable = true;
      exports = {
        "/var/lib/satisfactory-plus" = {
          "10.99.0.98" = plusFlags;
          "192.168.1.100" = plusFlags;
        };
      };
    };
  };
  networking.firewall.interfaces.enp9s0.allowedTCPPorts = [ 2049 ];
}
