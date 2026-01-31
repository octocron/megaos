# INFO: Create a CA: nebula-cert ca -name "megaport" -duration 2400d -out-dir /etc/nebula
{
  config,
  hostname,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.nebula;
in
{
  options.services.nebula.enable = mkEnableOption "enable nebula";

  config = mkIf cfg.enable {
    systemd = {
      tmpfiles.rules = [
        "d /etc/nebula 0750 root root -" # creates the folder as perm while not replacing content
        #"Z /etc/nebula - - - - 0644 root root" # sets files to these perms
      ];
      services."nebula@megaport".after = [ "sops-nix.service" ];
    };

    services.nebula.networks.megaport = {
      enable = true;
      isLighthouse = true;
      ca = config.sops.secrets."nebula/ca.crt".path; # "/etc/nebula/ca.crt";
      cert = config.sops.secrets."nebula/${hostname}.crt".path; # "/etc/nebula/hostname.crt"; lighthouse would be called hostname
      key = config.sops.secrets."nebula/${hostname}.key".path; # "/etc/nebula/hostname.key"; <- sensitive!

      listen = {
        host = "0.0.0.0";
        port = 4242;
      };

      staticHostMap = { }; # Lighthouses don't need map to other lighthouses

      # tun = {
      #   disabled = false;
      #   device = "nebula1";
      # };

      firewall = {
        outbound = [
          {
            port = "any";
            proto = "any";
            host = "any";
          }
        ];
        inbound = [
          {
            port = "any";
            proto = "any";
            host = "any";
          }
        ];
      };
    };
  };
}
