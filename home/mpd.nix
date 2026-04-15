{
  config,
  pkgs,
  ...
}:
# INFO: need to manually create ~/.config/mpd/playlists folder manually
# INFO: add missing album art: , sacad_r ~/Music 600 cover.jpg
{
  home = {
    packages = with pkgs; [
      mpc
      mpd-mpris
    ];
  };

  services.mpd = {
    enable = true;

    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists";
    dataDir = "${config.home.homeDirectory}/.local/share/mpd";

    network = {
      startWhenNeeded = false;
      listenAddress = "127.0.0.1";
      port = 6600;
    };

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }

      audio_output {
        type "fifo"
        name "Visualizer feed"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };
}
