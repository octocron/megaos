{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      mpc
      mpd-mpris
    ];

    # Ensure directories exist
    file.".config/mpd/playlists".source = pkgs.runCommand "mpd-playlists" { } ''
      mkdir -p $out
    '';
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
