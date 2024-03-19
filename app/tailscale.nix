{ pkgs, ... }:

{
  # Configure Tailscale
  programs.tailscale = {
    enable = true; 
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

#boot.kernel.sysctl = {
    # for tailscale exit node
#    "net.ipv6.conf.all.forwarding" = "1";
# };
}

