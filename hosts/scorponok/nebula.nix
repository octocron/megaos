{ hostname, ... }: {
  services.nebula.networks.megaport = {
    enable = true;
    isLighthouse = true;

    ca = "/etc/nebula/ca.crt";
    cert = "/etc/nebula/${hostname}.crt";
    key = "/etc/nebula/${hostname}.key";

    listen = {
      host = "0.0.0.0";
      port = 4242;
    };

    staticHostMap = { };

    settings = {
      punchy = {
        punch = true;
        respond = true;
        delay = "1s";
      };

      relay = {
        am_relay = false;
        use_relay = false;
      };
    };

    # INFO: firewall is default deny.  There is no way to write a deny rule!
    firewall = {
      # NOTE: Allow traffic TO this node
      inbound = [
        {
          # Allow icmp between any nebula hosts
          port = "any";
          proto = "icmp";
          host = "any";
        }

        {
          # Nebula SSH access for admins
          port = 22;
          proto = "tcp";
          groups = [ "admin" ];
        }
      ];

      # NOTE: Allow traffic FROM this node
      outbound = [
        {
          port = "any";
          proto = "any";
          host = "any";
        }
      ];
    };
  };
}
