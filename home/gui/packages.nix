{ pkgs, ... }: {
  home.packages = with pkgs; [
    albert # C++: Launcher
    amfora # Rust: markdown viewer
    appimage-run # Bash: Support App Images
    bibata-cursors
    #coppwr # Rust: manage pipewire gui
    code-cursor
    ffmpegthumbnailer # C++: lightweight video thumbnailer
    grim # C: screenshots
    imagemagick # C: edit compose convert images
    imv # Rust: image viewer
    libnotify # C: notifications
    material-icons
    meson
    papirus-icon-theme # for qt
    pwvucontrol # Rust:
    pcmanfm-qt # for qt
    pinentry-gtk2
    playerctl
    polkit_gnome
    pscircle
    python315
    qpwgraph # C++: pipewire graph gui interface
    ttyper # Rust: ↑ typing game
    v4l-utils
    wgpu-utils
    wttrbar

    # INFO: GTK THEMES
    gnome-themes-extra
    sassc
    gtk-engine-murrine
  ];
}
