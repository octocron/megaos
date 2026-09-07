{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.rust-motd
  ];

  environment.etc."rust-motd.kdl".text = ''
    global {
      version "1.0"
      progress-full-character "━"
      progress-empty-character "─"
      progress-prefix "["
      progress-suffix "]"
      time-format "%Y-%m-%d %H:%M:%S %Z"
    }

    components {
      command "hostname | figlet -f slant"
      memory swap-pos="beside"

      filesystems {
        filesystem name="/" mount-point="/"
        filesystem name="Vault" mount-point="/vault"
      }

      service-status {
        service display-name="Caddy" unit="caddy.service"
        service display-name="Hermes" unit="hermes-agent.service"
        service display-name="Nebula" unit="nebula@megaport.service"
        service display-name="Satisfactory" unit="satisfactory.service"
        service display-name="SSH" unit="sshd.service"
      }
      load-avg format="Load: {one:.02} {five:.02} {fifteen:.02}"

      uptime prefix="Uptime"
      last-run
    }
  '';

  users.motdFile = "/etc/rust-motd";

  system.activationScripts.rust-motd = ''
    PATH="${
      lib.makeBinPath [
        pkgs.bash
        pkgs.systemd
        pkgs.figlet
        pkgs.inetutils
      ]
    }:$PATH"

    ${pkgs.rust-motd}/bin/rust-motd \
      /etc/rust-motd.kdl \
      > /etc/rust-motd
  '';
}
