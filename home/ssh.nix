# NOTE: ssh -T git@github.com
# NOTE: ssh-agent is not needed when designating an IdentityFile
{ username, ... }: {
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
          user = username;
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_${username}"
          ];
        };

        "lockdown" = {
          hostname = "192.168.1.130";
        };

        "primus" = {
          hostname = "192.168.10.37";
        };

        "rodimus" = {
          hostname = "192.168.10.38";
        };
      };
    };
  };
}
