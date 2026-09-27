{
  config,
  gitEmail,
  pkgs,
  ...
}:
{
  networking.firewall.allowedTCPPorts = [ 443 ];
  services.caddy = {
    enable = true;
    email = gitEmail;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.4"
      ];

      hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
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

      "ollama.megaport.cc" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:11434
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
