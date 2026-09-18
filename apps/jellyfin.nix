{
  config,
  pkgs,
  ...
}:
{
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    jellyfin-ffmpeg
    libva-utils
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = false; # Caddy is the only public listener
    user = "jellyfin";
    group = "jellyfin";
    hardwareAcceleration = {
      enable = true;
      type = "vaapi";
      device = "/dev/dri/renderD128";
    };
  };

  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ];

  systemd.services.jellyfin.serviceConfig = {
    DeviceAllow = [
      "/dev/dri/renderD128"
      "/dev/dri/card0"
    ];
    SupplementaryGroups = [
      "render"
      "video"
    ];
  };
}
