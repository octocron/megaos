# INFO: Create a CA: nebula-cert ca -name "megaport" -duration 2400d -out-dir /etc/nebula
# TODO: sudo chmod --reference /etc/nix /etc/nebula
# TODO: sudo chmod --reference /etc/nix/nix.conf /etc/nebula/*
{ hostname, ... }: {
  services.nebula.networks.megaport = {
    enable = true;
    ca = "/etc/nebula/ca.crt";
    cert = "/etc/nebula/${hostname}.crt"; # lighthouse would be called hostname
    key = "/etc/nebula/${hostname}.key"; # <- sensitive!

    isLighthouse = false;
    lighthouses = [
      "10.99.0.37"
    ];
    staticHostMap = {
      "10.99.0.37" = [
        "192.168.10.37:4242"
      ];
      "10.99.0.38" = [
        "192.168.10.38:4242"
      ];
    };

    settings = {
      punchy = {
        punch = true;
        respond = true;
        delay = "1s";
      };

      relay = {
        am_relay = false;
        use_relays = false;
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
          # Allow ssh from admins
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
