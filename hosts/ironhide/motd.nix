{
  programs.rust-motd = {
    enable = true;
    enableMotdInSSHD = true;
    order = [
      "uptime"
      "banner"
    ];

    # INFO: { } TOML migrating to KDL
    settings = {
      command = {
        color = [
          "red"
          "hostname | figlet -f slant"
        ];
      };

      filesystems = {
        service_status = {
          Network = "systemd-networkd";
        };
      };
    };
  };
}
