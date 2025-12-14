{
  config,
  pkgs,
  ...
}:
let
  wallpaper1 = "${config.home.homeDirectory}/Pictures/Wallpapers/optilast.jpg";
  wallpaper2 = "${config.home.homeDirectory}/Pictures/Wallpapers/groot_oldies.png";
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper1}
    preload = ${wallpaper2}

    wallpaper = HDMI-A-1,${wallpaper1}
    wallpaper = DP-1,${wallpaper2}

    ipc = off
  '';

  home.file.".config/hypr/hyprpaper.conf".onChange = ''
    pkill -USR1 hyprpaper || true
  '';

  # Optional: autostart hyprpaper
  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprpaper wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
