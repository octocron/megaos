{ hostname, ... }:
{
  programs = {
    ssh-agent = {
      enable = true;
      enableZshIntegration = true;
    };
    ssh = {
      enable = true;
      extraConfig = ''
        addKeysToAgent yes
        IdentityFile ~/.ssh/id_"${hostname}"
      '';
    };
  };
}
