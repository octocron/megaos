This is only the beginning of my sorrows haha!

#### TODO:

- gui apps??
- containers
- sops-nix

#### PROG:

- crowdsec
- tailscale

#### DONE:

- direnv
- git
- gpg
- mullvad
- nix-index
- nixvim (megavim)
- ssh
- smb
- starship
- swap ram
- tailscale
- thinned pkgs
- tmux
- unstable

#### UNWANTED:

- agenix # sops-nix is better, agenix =/= home manager or darwin

#### BROKEN:

- wezterm # dev not supporting nix, using kitty

Tests
You can run the tests with

```zsh
nix flake check
```

You can run the integration tests in interactive mode like this:

```zsh
nix run .#checks.x86_64-linux.integration.driverInteractive
```

After it starts, enter run_tests() to run the tests.
