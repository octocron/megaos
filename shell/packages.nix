{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # apps
    audacity
    blender
    brave
    discord
    davinci-resolve
    gimp
    godot_4
    gparted
    kdenlive
    mpv
    obs-studio
    openra
    plex-media-player
    plexamp
    signal-desktop
    spotify
    superTuxKart
    xonotic

    # cli tools
    amfora
    asciinema
    bandwhich
    bat
    bottom
    btop
    cargo-cache
    cargo-expand
    cmatrix
    coreutils
    curl
    ctop
    diff-so-fancy
    du-dust
    duf
    exiftool
    eza
    fd
    fdupes
    figlet
    findutils
    fx
    git
    git-crypt
    gitmoji-cli
    gping
    go
    grim
    htop
    hugo
    hyperfine
    imv
    inxi
    just
    killall
    lazydocker
    lazygit
    libvirt
    lua
    magic-wormhole
    mosh
    navi
    neofetch
    neovim
    pinentry
    procs
    pscircle
    ripgrep
    rustup
    scc
    sd
    slurp
    sniffnet
    speedread
    tailscale
    tmate
    tokei
    tree
    xclip
    xsel
    unrar
    unzip
    vim
    wget
    zip

    # language servers
    ccls # c / c++
    gopls
    nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    sumneko-lua-language-server
    nil # nix
    nodePackages.pyright

    # formatters and linters
    alejandra # nix
    black # python
    ruff # python
    deadnix # nix
    golangci-lint
    lua52Packages.luacheck
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
    sqlfluff
    tflint
  ];
}
