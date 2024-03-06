{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  home.packages = with pkgs; [
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
    htop
    hugo
    hyperfine
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
    ripgrep
    rustup
    scc
    sd
    slurp
    sniffnet
    speedread
    tealdeer
    thefuck
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
