{ hostname, ... }:
{
  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "~/.ssh/id_${hostname}";
      extraConfig = ''
        addKeysToAgent yes
        IdentityFile ~/.ssh/id_"${hostname}"
        ServerAliveInterval 60
        ServerAliveCountMax 3
      '';
    };
  };
}
