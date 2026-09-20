{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.steam-servers.satisfactory;
in
{
  options.services.steam-servers.satisfactory = {
    enable = mkEnableOption "Satisfactory dedicated server";
    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = "Automatically start the server on boot.";
    };
    installDir = mkOption {
      type = types.str;
      default = "/var/lib/satisfactory";
      description = "Directory where server files are installed";
    };
    user = mkOption {
      type = types.str;
      default = "steam";
      description = "User account under which the server runs";
    };
    groups = mkOption {
      type = types.str;
      default = "steam";
      description = "Group account for the server";
    };
    port = mkOption {
      type = types.int;
      default = 7777;
      description = "Game port for the server";
    };
    reliablePort = mkOption {
      type = types.int;
      default = 8888;
      description = "Reliable port for the server";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open firewall ports for server";
    };
    # INFO: validate rewrites the tree and removes SML. Off after first install if using mods.
    validate = mkOption {
      type = types.bool;
      default = true;
      description = "steamcmd validate on start. Keep false on the modded tree.";
    };
    experimental = mkOption {
      type = types.bool;
      default = false;
      description = "Use the experimental branch of the server";
    };
  };

  config = mkIf cfg.enable {
    # INFO: Create Steam User & Group
    users = {
      groups.${cfg.groups} = {
        gid = 990;
      };
      users.${cfg.user} = {
        uid = 993;
        isSystemUser = true;
        group = cfg.groups;
        home = cfg.installDir;
        createHome = true;
        description = "Satisfactory server user";
      };
    };

    # INFO: systemd service
    systemd.services.satisfactory = {
      description = "Satisfactory Dedicated Server";
      wantedBy = mkIf cfg.autoStart [ "multi-user.target" ];
      after = [
        "network-online.target"
        "nebula@megaport.service"
      ];
      requires = [ "network-online.target" ];
      wants = [ "nebula@megaport.service" ];
      serviceConfig = {
        User = cfg.user;
        Group = cfg.groups;
        WorkingDirectory = cfg.installDir;
        Restart = "on-failure";
        KillSignal = "SIGINT";
        TimeoutStopSec = 300;
        ExecStartPre = [
          ''
            ${pkgs.steamcmd}/bin/steamcmd \
              +login anonymous \
              +force_install_dir ${cfg.installDir} \
              +app_update 1690800 ${optionalString cfg.experimental "-beta experimental"} ${optionalString cfg.validate "validate"} \
              +quit
          ''
        ];
        ExecStart = ''
          ${pkgs.steam-run}/bin/steam-run ${cfg.installDir}/FactoryServer.sh \
            -Port=${toString cfg.port} \
            -ReliablePort=${toString cfg.reliablePort} \
            -ExternalReliablePort=${toString cfg.reliablePort} \
            -ini:Game:[/Script/Engine.GameSession]:MaxPlayers=16 \
            -unattended
        '';
      };
    };
  };
}
