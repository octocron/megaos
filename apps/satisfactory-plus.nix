{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.steam-servers.satisfactory-plus;
in
{
  options.services.steam-servers.satisfactory-plus = {
    enable = mkEnableOption "Satisfactory dedicated server (modded / Plus)";
    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = "Automatically start the server on boot.";
    };
    installDir = mkOption {
      type = types.str;
      default = "/var/lib/satisfactory-plus";
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
      default = 7779;
      description = "Game port for the server";
    };
    reliablePort = mkOption {
      type = types.int;
      default = 8889;
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
      default = false;
      description = "steamcmd validate on start. Keep false on the modded tree.";
    };
    experimental = mkOption {
      type = types.bool;
      default = false;
      description = "Use the experimental branch of the server";
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfg.installDir} 0750 ${cfg.user} ${cfg.groups} -"
    ];

    # INFO: systemd service
    systemd.services.satisfactory-plus = {
      description = "Satisfactory Dedicated Server (Plus / mods)";
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
        RestartSec = "10s";
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
