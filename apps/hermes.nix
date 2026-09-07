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

  virtualisation.docker.enable = false;
  services.hermes-agent = {
    enable = true;
    container.enable = true;

    # ── Model ──────────────────────────────────────────────────────────
    settings = {
      model = {
        base_url = "https://openrouter.ai/api/v1";
        default = "anthropic/claude-opus-4.6";
      };
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

    # ── Container options ──────────────────────────────────────────────
    container = {
      image = "ubuntu:26.04";
      backend = "podman";
      hostUsers = [ "${username}" ];
      extraVolumes = [ "/home/${username}/projects/hermes:/projects:rw" ];
      extraOptions = [
      ];
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
