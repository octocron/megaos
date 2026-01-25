{
  hostname,
  pkgs,
  ...
}:
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

    # Enable ssh-agent service
    systemd.user.services.ssh-agent = {
      Unit = {
        Description = "SSH key agent";
        PartOf = [ "default.target" ];
      };
      Service = {
        Type = "simple";
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
        ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
