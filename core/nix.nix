{
  pkgs,
  username,
  ...
}:
{
  #-----------------NIX-OPTIMIZATIONS------------------#
  nix = {
    nrBuildUsers = 64;
    settings = {
      cores = 2; # 0 means all available cores
      warn-dirty = false;
      auto-optimise-store = true;
      download-buffer-size = 240 * 1024 * 1024;
      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;
      max-jobs = 4; # "auto" means all, 0 means use remote specified in builders
      trusted-users = [
        "root"
        "@wheel"
      ];
      allowed-users = [
        "root"
        "${username}"
        "@wheel"
      ];
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      gc = {
        automatic = true;
        persistent = true; # INFO: runs collection if missed while powered down
        dates = "weekly";
        options = "--delete-older-than 60d";
      };

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # For when dangon devs use EOL dependencies, grrrr..
    ];
  };

  # NOTE: Profile Garbage Collection
  systemd.services.nix-clean-profiles = {
    description = "Remove generations older than 60d from all named NixOS system profiles";
    wantedBy = [ "multi-user.target" ]; # Ensure it can run after boot if needed
    serviceConfig = {
      Type = "oneshot";
      ExecStart =
        pkgs.writeShellApplication
          {
            name = "clean-profiles";
            runtimeInputs = [ pkgs.nix ];
            text = ''
              for profile in /nix/var/nix/profiles/system-profiles/*; do
                if [[ -e "$profile" ]]; then
                  echo "Cleaning generations older than 30d for profile: $profile"
                  nix profile wipe-history --profile "$profile" --older-than 60d || true
                fi
              done
            '';
          }
          .outPath
        + "/bin/clean-profiles";
    };
  };

  systemd.timers.nix-clean-profiles = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h"; # Avoid all timers firing at once
    };
  };
}
