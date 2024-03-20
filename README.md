This is only the beginning of my sorrows haha!
The rabbit hole of nixos has begun!

#### TODO:
- unstable?
- nixvim
- gpg
- ssh
- gui apps??
- flake-parts
- containers
- nix-index
- swap ram
- sops-nix


#### PROG:
- crowdsec
- neovim
- tailscale



#### DONE:
- direnv
- git
- mullvad
- smb
- starship
- tailscale
- thinned pkgs
- tmux

#### UNWANTED:
- agenix            # sops-nix is better, agenix =/= home manager or darwin 


#### BROKEN:
- wezterm           # dev not supporting nix, using kitty

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
