{ hostname, ... }:
{
  programs = {
    ssh = {
      enable = true;
      extraConfig = ''
        addKeysToAgent yes
        IdentityFile ~/.ssh/id_"${hostname}"
      '';
      #enableDefaultConfig = false;
      # matchBlocks = {
      #   "*" = {
      #     addKeysToAgent = "config.sops.secrets.ssh.id_${hostname}.key";
      #   };
      # };
    };
  };
}
