# INFO: check used port with netstat -tulpn
{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.caddy;
in
{
  options.services.caddy.enable = mkEnableOption "enable caddy";

  config = mkIf cfg.enable {
    # NOTE: curl localhost -i -L -k
    virtualHosts = {
      "localhost".extraConfig = ''
        respond "Hello, world!"
      '';
      "satisfactory.megaport.cc" = {
        extraConfig = ''
          reverse_proxy satisfactory.megaport.cc:7777
        '';
      };
    };
  };
}
