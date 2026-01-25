{ hostname, ... }:
{
  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = true;
      extraConfig = ''
        addKeysToAgent yes
        IdentityFile ~/.ssh/"${hostname}"
        ServerAliveInterval 60
        ServerAliveCountMax 3
      '';
    };
  };
}
