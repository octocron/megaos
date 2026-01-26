# NOTE: ssh -T git@github.com
{
  hostname,
  username,
  ...
}:
{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
          identityFile = [
            "~/.ssh/energon"
            "config.sops.secrets.ssh.id_${hostname}.path"
          ];
          identitiesOnly = true;
          user = "${username}";
        };
      };
    };
  };
}
