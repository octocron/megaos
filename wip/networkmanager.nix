{
  config,
  hostname,
  ...
}:
{
  #-----------------NETWORKING------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
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
  };
}
