{
  config,
  hostname,
  ...
}:
{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "config.sops.secrets.ssh.id_${hostname}.key";
        };
      };
    };
  };
}
