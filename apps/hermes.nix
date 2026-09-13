{
  config,
  pkgs,
  username,
  ...
}:
{
  sops = {
    secrets = {
      "hermes-env" = { };
      "hermes-dashboard-username" = { };
      "hermes-dashboard-password" = { };
      "hermes-dashboard-secret" = { };
    };

    templates."hermes-dashboard-env" = {
      content = ''
        HERMES_DASHBOARD_BASIC_AUTH_USERNAME=${config.sops.placeholder."hermes-dashboard-username"}
        HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=${config.sops.placeholder."hermes-dashboard-password"}
        HERMES_DASHBOARD_BASIC_AUTH_SECRET=${config.sops.placeholder."hermes-dashboard-secret"}
      '';
    };
  };

  #networking.firewall.interfaces."nebula.megaport".allowedTCPPorts = [ 11434 ];
  virtualisation.docker.enable = false;
  services.hermes-agent = {
    enable = true;

    # ── Container options ──────────────────────────────────────────────
    container = {
      enable = true;
      image = "ubuntu:26.04";
      backend = "podman";
      hostUsers = [ "${username}" ];
      extraVolumes = [ "/home/${username}/projects/hermes:/projects:rw" ];
      extraOptions = [
      ];
    };

    # ── Model ──────────────────────────────────────────────────────────
    settings = {
      model = {
        provider = "custom";
        base_url = "https://ollama.megaport.cc/v1";
        default = "qwen3:8b-q4_K_M";
      };

      fallback_providers = [
        {
          provider = "openrouter";
          model = "deepseek/deepseek-v4-flash";
        }
      ];

      toolsets = [ "all" ];
      max_turns = 100;
      terminal = {
        backend = "local";
        cwd = ".";
        timeout = 180;
      };
      compression = {
        enabled = true;
        threshold = 0.85;
        summary_model = "google/gemini-3.8-flash-preview";
      };
      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };
      display = {
        compact = false;
        personality = "kawaii";
      };
      agent = {
        max_turns = 60;
        verbose = false;
      };

      # INFO: Discord Gateway
      discord = {
        require_mention = true; # Require @mention in server channels
        thread_require_mention = false; # require @mention in threads too
        auto_thread = true; # Auto-create threads on @mention
        reactions = true; # Add emoji reactions during processing
        free_response_channels = [
          "1547794898311319673"
        ]; # Channel IDs that do not require @mention
        ignored_channels = [
          "919798584956842084"
        ]; # Channel IDs where bot never responds
        no_thread_channels = [
          "166244573083860992"
        ]; # Channel IDs where bot responds without threading
      };
    };

    # ── Chat (discord/telegram) ───────────────────────────────────────
    extraDependencyGroups = [
      "messaging"
    ];

    # ── Secrets ────────────────────────────────────────────────────────
    environmentFiles = [
      config.sops.secrets."hermes-env".path
      config.sops.templates."hermes-dashboard-env".path
    ];

    # ── Documents ──────────────────────────────────────────────────────
    workingDirectory = "/var/lib/hermes/workspace";

    documents = {
      "AGENTS.md" = ./documents/AGENTS.md;
    };

    hermesHomeFiles = {
      "SOUL.md" = ./documents/SOUL.md;
    };

    # ── MCP Servers ────────────────────────────────────────────────────
    mcpServers = {
      filesystem = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "/data/workspace"
        ];
      };
      github = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-github"
        ];
        env.GITHUB_PERSONAL_ACCESS_TOKEN = "\${GITHUB_TOKEN}";
      };
    };

    # ── Service tuning ─────────────────────────────────────────────────
    addToSystemPackages = true;
    extraArgs = [ "--verbose" ];
    restart = "always";
    restartSec = 5;
  };

  # ── Keep Permissions ───────────────────────────────────────────────
  systemd.tmpfiles.rules = [
    "a+ /var/lib/hermes/.hermes - - - - group:hermes:r-x"
    "a+ /var/lib/hermes/.hermes - - - - default:group:hermes:r-x"
  ];

  system.activationScripts.hermes-acl = {
    text = ''
      if [ -d /var/lib/hermes/.hermes ]; then
        ${pkgs.acl}/bin/setfacl -R -m g:hermes:rX /var/lib/hermes/.hermes
        ${pkgs.acl}/bin/setfacl -R -d -m g:hermes:rX /var/lib/hermes/.hermes
      fi
    '';

    deps = [
      "users"
      "groups"
    ];
  };

  # ── hermes serve (dashboard/desktop backend) ─────────────────────────────
  systemd.services.hermes-serve = {
    description = "Hermes Agent Dashboard (hermes serve)";
    after = [ "hermes-agent.service" ];
    requires = [ "hermes-agent.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.podman}/bin/podman exec hermes-agent /data/current-package/bin/hermes serve --host 0.0.0.0 --port 9119";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
