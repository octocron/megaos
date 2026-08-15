{
  pkgs,
  username,
  ...
}:
{
  # still need to $ sudo smbpasswd -a $username
  services = {
    samba = {
      package = pkgs.samba;
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "server smb encrypt" = "required";
          "server min protocol" = "SMB3";
        };

        documents = {
          path = "/home/${username}/Documents/windows";
          "read only" = "no";
          browseable = "yes";
          "valid users" = "${username}";
        };
      };
    };

    samba-wsdd = {
      # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };
  };
}
