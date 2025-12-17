{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # apps
    audacity
    brave
    discord
    davinci-resolve
    gimp
    godot_4
    gparted
    mpv
    modrinth-app
    mullvad-vpn
    obs-studio
    plex-desktop
    plexamp
    signal-desktop
    spotify
    superTuxKart
    transmission_4-gtk
    xonotic

    # cli tools
    amfora # Rust: markdown viewer
    asciinema # Rust: terminal recorder
    aria2 # C++: ↑ wget
    bandwhich # Rust: real time network monitor
    bat # Rust: ↑ cat
    bibata-cursors
    bottom # Rust: ↑ htop
    btop # C++: htop
    bzip3 # C: ↑ bzip2
    cargo-cache # Rust:
    cargo-expand # Rust:
    cmatrix # C: terminal matrix
    cmus # C: terminal music player
    #cointop # Go: cryto market
    comma # Rust: like nix shell
    coreutils # C: utils
    croc # Go: ↑ magic-wormhole
    curl # C:
    curlie # Go: frontend to curl that add use of httpie
    ctop # Go: htop for containers
    diff-so-fancy # Perl: ↑ diff
    dogdns # Rust: ↑ dig
    dust # Rust: ↑ du
    duf # Go: ↑ df
    exiftool # Perl: ↑ exif
    eza # Rust: ↑ ls
    fd # Rust: ↑ find
    fdupes # C: deduplicator
    ffmpeg # C:
    ffmpegthumbnailer # C++: lightweight video thumbnailer
    figlet # C: ascii art banner generator | http://www.figlet.org/examples.html
    findutils # C: has find xargs
    font-awesome
    fq # Go: ↑ jq for binary
    fx # Go: ↑ JSON viewer
    gh # Go: github cli
    git # C: git
    git-crypt # C++:
    gitmoji-cli # JS: emoji commit messages
    glab # Go: gitlab cli (like gh)
    glances # Python: ↑ resource monitor
    gnupg # C: gpg **
    go # Assembly: garbage collector | C++: frontend
    gping # Rust: ↑ ping
    grex # Rust: ↑ regex
    grim # C: screenshots
    hex # Rust: ↑ xxd
    hugo # static site generator
    hyperfine # Rust: cmd benchmark
    hyprpicker # JS: popup picker
    imagemagick # C: edit compose convert images
    imv # Rust: image viewer
    inxi # Bash: ↑ system info
    isd # Python: systemd tui
    just # ↑ make
    killall # C: shutdown processes
    lazydocker # Go: full docker mgmt app
    lazygit # Go: full git mgmt app
    libnotify # C: notifications
    libvirt # C:
    lm_sensors # C: hardware sensor data
    lua # C:
    man-db # C:
    material-icons
    meson
    mosh # C++:
    most # C: ↑ less
    navi # Rust: cli cheatsheet
    ninja # C++: build system
    nix-melt # Rust: ranger-like flake.lock viewer
    noto-fonts-color-emoji
    nurl # Rust: ↑ fetch hash from repo url
    pavucontrol # C: gtk audio gui
    pciutils # C: Bins (lspci, pcilmr, setpci) needed for inxi as inspection tool
    pkg-config # C: lib paths
    pinentry-gtk2
    polkit_gnome
    procs # Rust: ↑ ps
    pscircle
    rage # Rust: ↑ age
    ripgrep # Rust: ↑ grep
    ripgrep-all # Rust: ↑ extend rg to search pdf, docx, etc
    rofi
    rsync # C: inc file xfer
    rustic # Rust: deduplicated backup
    rustup # Rust: rust toolchain
    scc # Go: code count
    scriptisto # Rust: ↑ script editor
    sd # Rust: ↑ sed
    slurp
    sniffnet # Rust: ↑ wireshark
    socat # C: for screenshots
    sops # Go: ↑ secret manager
    ssh-to-age # Go: convert ssh key to age
    spacer # Rust: ↑ insert space when cli output stops
    speedread # Perl:
    swaynotificationcenter
    symbola
    termusic # Rust: ↑ cmus
    tmate # C: instant terminal sharing
    tokei # Rust: ↑ stats about code project
    tre # C: ↑ tree
    trippy # Rust: ↑ traceroute + ping + bandwhich in one
    ttyper # Rust: ↑ typing game
    unrar # C:
    unzip # C:
    up # Go: ↑ pipe with live preview
    uutils-coreutils # Rust: ↑ coreutils rewrite
    v4l-utils
    viddy # Rust: ↑ watch
    vim # C: ↑↑ modal editor
    w3m # C: text based browser
    wget # C: ↑ download
    wl-clipboard
    wthrr # Rust: ↑ wttr
    wttrbar
    xclip
    xsel
    yaydl # Rust: ↑ youtube-dl
    ydotool
    yq-go # Go: yaml processor
    zip # C: zip files
    zoxide # Rust: ↑ cd
    zsh-nix-shell # ZSH:

    # nix search
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];
}
