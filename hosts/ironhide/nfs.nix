{ config, ... }:
let
  steamGid = toString config.users.groups.steam.gid;
  steamUid = toString config.users.users.steam.uid;
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
      exports = ''
        /var/lib/satisfactory-plus 192.168.1.100(rw,sync,no_subtree_check,all_squash,anonuid=${steamUid},anongid=${steamGid}) 10.99.0.98(rw,sync,no_subtree_check,all_squash,anonuid=${steamUid},anongid=${steamGid})
      '';
    };
  };
  networking.firewall.interfaces.enp9s0.allowedTCPPorts = [ 2049 ];
}
