# INFO: Create a CA: nebula-cert ca -name "megaport" -duration 2400d -out-dir /etc/nebula
{
  config,
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
    services.nebula.networks.megaport = {
      enable = true;
      isLighthouse = true;
      ca = "/etc/nebula/ca.crt";
      cert = "/etc/nebula/hostname.crt"; # lighthouse would be called hostname
      key = "/etc/nebula/hostname.key"; # <- sensitive!

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
