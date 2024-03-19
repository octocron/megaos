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
}

