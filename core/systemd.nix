{ pkgs, ... }:
{
  #-----------------------SYSTEMD----------------------------#
  systemd = {
    # INFO: give more time for services to shutdown gracefully
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
    services = {
      # INFO: optimise nix builders (keep from running out of memory)
      nix-daemon.serviceConfig = {
        MemoryAccounting = true;
        MemoryMax = "90%";
        OOMScoreAdjust = 500;
      };

      clean-hyprland-profile = {
        description = "Remove hyprland profile generations older than 100 days";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.nix}/bin/nix profile wipe-history --profile /nix/var/nix/profiles/system-profiles/hyprland --older-than 100d";
        };
      };

      tailscale-autoconnect = {
        description = "Automatic connection to Tailscale";
        after = [
          "network-pre.target"
          "tailscale.service"
        ];
        wants = [
          "network-pre.target"
          "tailscale.service"
        ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "oneshot";
        script = with pkgs; ''
          # wait for tailscaled to settle
          sleep 2
          # check if we are already authenticated to tailscale
          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then
            exit 0
          fi
          # otherwise authenticate with tailscale
          ${tailscale}/bin/tailscale up --auth-key file:/etc/tailscale/tskey-reusable
        '';
      };
    };

    timers.clean-hyprland-profile = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "weekly"; # or "daily", "monthly", etc.
        Persistent = true;
        RandomizedDelaySec = "3h"; # optional: spread load
      };
    };
  };
}
