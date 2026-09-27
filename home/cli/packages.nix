{ pkgs, ... }: {
  home.packages = with pkgs; [
    asciinema # Rust: terminal recorder
    aria2 # C++: ↑ wget
    bandwhich # Rust: real time network monitor
    bottom # Rust: ↑ htop
    btop # C++: htop
    bzip3 # C: ↑ bzip2
    cargo-cache # Rust:
    cargo-expand # Rust:
    comma # Rust: like nix shell
    compose2nix # Go: convert docker-compose to nix
    coreutils # C: utils
    croc # Go: ↑ magic-wormhole
    curl # C:
    curlie # Go: frontend to curl that add use of httpie
    ctop # Go: htop for containers
    diff-so-fancy # Perl: ↑ diff
    doggo # Rust: ↑ dig
    dust # Rust: ↑ du
    duf # Go: ↑ df
    exiftool # Perl: ↑ exif
    eza # Rust: ↑ ls
    fd # Rust: ↑ find
    fdupes # C: deduplicator
    ffmpeg # C:
    figlet # C: ascii art banner generator | http://www.figlet.org/examples.html
    findutils # C: has find xargs
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
    hex # Rust: ↑ xxd
    hugo # static site generator
    hyperfine # Rust: cmd benchmark
    hstr # C: better shell history (ctrl r)
    inxi # Bash: ↑ system info
    isd # Python: systemd tui
    just # ↑ make
    killall # C: shutdown processes
    lazydocker # Go: full docker mgmt app
    lazygit # Go: full git mgmt app
    libvirt # C:
    lm_sensors # C: hardware sensor data
    lua # C:
    lychee # Rust: Link checker
    man-db # C:
    mosh # C++:
    most # C: ↑ less
    #mov-cli-rs # Rust mov-cli
    navi # Rust: cli cheatsheet
    ninja # C++: build system
    nix-melt # Rust: ranger-like flake.lock viewer
    nurl # Rust: ↑ fetch hash from repo url
    pciutils # C: Bins (lspci, pcilmr, setpci) needed for inxi as inspection tool
    procs # Rust: ↑ ps
    rage # Rust: ↑ age
    ripgrep # Rust: ↑ grep
    ripgrep-all # Rust: ↑ extend rg to search pdf, docx, etc
    rsync # C: inc file xfer
    rustic # Rust: deduplicated backup
    #rustnet # Rust: netstat, ss, wireshark, tcpdump all in one, can ssh too!
    rustup # Rust: rust toolchain
    scc # Go: code count
    scriptisto # Rust: ↑ script editor
    sd # Rust: ↑ sed
    sniffnet # Rust: ↑ wireshark
    socat # C: for screenshots
    sops # Go: ↑ secret manager
    ssh-to-age # Go: convert ssh key to age
    spacer # Rust: ↑ insert space when cli output stops
    speedread # Perl:
    terminal-typeracer
    termusic # Rust: ↑ cmus
    tokei # Rust: ↑ stats about code project
    tre # C: ↑ tree
    trippy # Rust: ↑ traceroute + ping + bandwhich in one
    tuxedo # Rust: todo.txt manager
    udiskie
    unzip # C:
    up # Go: ↑ pipe with live preview
    uutils-coreutils # Rust: ↑ coreutils rewrite
    viddy # Rust: ↑ watch
    vim # C: ↑↑ modal editor
    w3m # C: text based browser
    wget # C: ↑ download
    witr # GO: why is this running
    wl-clipboard
    wthrr # Rust: ↑ wttr
    xclip
    xsel
    yq-go # Go: yaml processor
    zip # C: zip files
    zoxide # Rust: ↑ cd
    zsh-nix-shell # ZSH: use zsh in a nix-shell environment

    # nix search
    (writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];
}
