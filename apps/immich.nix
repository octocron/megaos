{ lib, ... }: {
  systemd.tmpfiles.rules = [
    "d /vault/photos 0750 immich immich -"
  ];

  users.users.immich.extraGroups = [
    "render"
    "video"
  ];

  services.immich = {
    enable = true;
    accelerationDevices = [ "/dev/dri" ];
    host = "127.0.0.1";
    mediaLocation = "/vault/photos";
    openFirewall = false;
    port = 2283;
  };

  systemd.services.immich-server.serviceConfig.PrivateDevices = lib.mkForce false;
}
