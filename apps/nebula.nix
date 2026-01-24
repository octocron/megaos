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
        "d /etc/nebula 0750 root root -"
        #"Z /etc/nebula - - - - 0644 root root"
      ];
      services."nebula@megaport".after = [ "sops-nix.service" ];
    };
    environment.systemPackages = with pkgs; [ nebula ];

    services.nebula.networks.megaport = {
      enable = true;
      isLighthouse = true;
      ca = config.sops.secrets."nebula/ca.crt".path; # "/etc/nebula/ca.crt";
      cert = config.sops.secrets."nebula/${hostname}.crt".path; # "/etc/nebula/hostname.crt"; lighthouse would be called hostname
      key = config.sops.secrets."nebula/${hostname}.key".path; # "/etc/nebula/hostname.key"; <- sensitive!
    };
  };
}
