# NOTE: Leave address, publicKey, and endpoint empty until the Mullvad WireGuard config exists. table = "51820"
# NOTE: is the part that stops this iface from becoming the host default route. dns = [ ] stops it from rewriting Unbound.
# NOTE: Pin users.users.qbittorrent.uid in arr.nix if eval complains that uid is null (same pattern as steam).
{ config, ... }: {
  sops.secrets.mullvad-wg-private = {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.wg-quick.interfaces.mullvad = {
    address = [
      # "10.64.x.x/32"
    ];
    dns = [ ];
    privateKeyFile = config.sops.secrets.mullvad-wg-private.path;
    table = "51820";
    peers = [
      {
        publicKey = "";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "";
        persistentKeepalive = 25;
      }
    ];
    preUp = ''
      ip rule add uidrange ${toString config.users.users.qbittorrent.uid}-${toString config.users.users.qbittorrent.uid} lookup 51820
    '';
    preDown = ''
      ip rule del uidrange ${toString config.users.users.qbittorrent.uid}-${toString config.users.users.qbittorrent.uid} lookup 51820
    '';
  };
}
