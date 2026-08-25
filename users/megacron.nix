{
  config,
  pkgs,
  username,
  ...
}:
{
  #-----------------------USERS-----------------------#
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      "${username}" = {
        homeMode = "755";
        linger = true; # NOTE: for restarting ollama service after reboot
        isNormalUser = true;
        description = username;
        extraGroups = [
          "audio"
          "docker"
          "libvirtd"
          "networkmanager"
          "qemu-libvirtd"
          "scanner"
          "video"
          "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.passwordHash.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7Nb8wXQWd9H69U6TzPoE1MJDzUbGZSwwJCaXBvzgdb megacron"
        ];
      };
    };
  };
}
