{
  # INFO: Acquisition stack. Playback stays in jellyfin.nix.
  # NOTE: Indexers, API keys, and qBittorrent login are set in each WebUI.
  users.groups.media = { };
  users.users = {
    bazarr.extraGroups = [ "media" ];
    jellyfin.extraGroups = [ "media" ];
    lidarr.extraGroups = [ "media" ];
    megacron.extraGroups = [ "media" ];
    qbittorrent.extraGroups = [ "media" ];
    radarr.extraGroups = [ "media" ];
    sonarr.extraGroups = [ "media" ];
  };

  systemd.tmpfiles.rules = [
    "d /downloads/complete 2775 megacron media -"
    "d /downloads/incomplete 2775 megacron media -"
    "d /vault/movies 2775 megacron media -"
    "d /vault/music 2775 megacron media -"
    "d /vault/tv 2775 megacron media -"
  ];

  services = {
    bazarr = {
      enable = true;
      group = "media";
      openFirewall = false;
    };
    lidarr = {
      enable = true;
      group = "media";
      openFirewall = false;
    };
    prowlarr = {
      enable = true;
      openFirewall = false;
    };
    qbittorrent = {
      enable = true;
      group = "media";
      openFirewall = false;
      torrentingPort = 6881;
      webuiPort = 8181;
      serverConfig = {
        LegalNotice.Accepted = true;
        BitTorrent.Session = {
          DefaultSavePath = "/downloads/complete";
          TempPath = "/downloads/incomplete";
          TempPathEnabled = true;
        };
        Preferences.WebUI = {
          CSRFProtection = false;
          HostHeaderValidation = false;
        };
      };
    };
    radarr = {
      enable = true;
      group = "media";
      openFirewall = false;
    };
    seerr = {
      enable = true;
      openFirewall = false;
      port = 5055;
    };
    sonarr = {
      enable = true;
      group = "media";
      openFirewall = false;
    };
  };
}
