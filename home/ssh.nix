# NOTE: ssh -T git@github.com
# NOTE: ssh-agent is not needed when designating an IdentityFile
{ username, ... }:
{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
          identityFile = [
            "~/.ssh/id_${username}"
          ];
          identitiesOnly = true;
          user = "${username}";
        };
      };
    };
  };
}
