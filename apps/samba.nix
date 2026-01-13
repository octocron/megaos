{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.samba;
in
{
  options.services.samba.enable = mkEnableOption "enable samba";

  config = mkIf cfg.enable {
    # still need to $ sudo smbpasswd -a $username
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "server smb encrypt" = "required";
          "server min protocol" = "SMB3";
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
