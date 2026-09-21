{
  config,
  gitEmail,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;
    email = gitEmail;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.4"
      ];

      hash = "sha256-Olz4W84Kiyldy+JtbIicVCL7dAYl4zq+2rxEOUTObxA=";
    };

    environmentFile = config.sops.templates."caddy-env".path;

    globalConfig = ''
      acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    '';

    virtualHosts = {
      "*.megaport.cc" = {
        extraConfig = ''
          tls {
            dns cloudflare {
              api_token {env.CLOUDFLARE_API_TOKEN}
            }
          }
        '';
      };

      "hermes.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 0.0.0.0:9119
        '';
      };

      "immich.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 0.0.0.0:2283
        '';
      };

      "jellyfin.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 0.0.0.0:8096
        '';
      };

      "metube.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 0.0.0.0:8081
        '';
      };

      "sf.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 0.0.0.0:7777
        '';
      };

      # NOTE: ARR Stack
      "bazarr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:6767
        '';
      };

      "lidarr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8686
        '';
      };

      "prowlarr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9696
        '';
      };

      "qbittorrent.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8181
        '';
      };

      "radarr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:7878
        '';
      };

      "seerr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:5055
        '';
      };

      "sonarr.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8989
        '';
      };
    };
  };

  sops = {
    secrets.CF_API_TOKEN = {
      owner = "caddy";
      group = "caddy";
      mode = "0400";
    };

    templates."caddy-env" = {
      content = ''
        CLOUDFLARE_API_TOKEN=${config.sops.placeholder.CF_API_TOKEN}
      '';
    };
  };
}
