{ hostname, ... }: {
  #-----------------NETWORKD------------------------#
  networking = {
    hostName = hostname; # Defines hostname.
    useNetworkd = true;
    wireless = {
      iwd = {
        enable = false;
        settings = {
          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
          Settings.AutoConnect = true;
        };
      };
    };
  };
}
