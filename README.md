This is only the beginning of my sorrows haha!

#### TODO:

> containers

- crowdsec
- technitium
- caddy
- satisfactory
- minecraft
- prometheus
- grafana

#### PROG:

- crowdsec

#### DONE:

- direnv
- nixvim (megavim)
- sops-nix

### Live Image

> Download ~~Graphical~~ img from [nixos.org](https://nixos.org/download/#nix-install-linux)  
> burn img to USB with [BalenaEtcher](https://etcher.balena.io/)  
> plugin and boot to bios then hot boot off the USB (CMS: on Secure Boot: off)  
> Follow Graphical instructions [nixos.org](https://nixos.org/manual/nixos/stable/#ch-installation)  
> Shutdown pull USB then boot to bios again to set the boot order to NixOS drive

### megaOS

> Make your own keys, place on USB, adjust paths accordingly.
> Nebula Prep

```zsh
sudo mkdir /etc/nebula
sudo cp /run/media/megacron/PATRIOT/nebula/ca.crt /etc/nebula/
sudo cp /run/media/megacron/PATRIOT/nebula/energon.crt /etc/nebula/
sudo cp /run/media/megacron/PATRIOT/nebula/energon.key /etc/nebula/
sudo chmod --reference /etc/nix /etc/nebula
sudo chmod --reference /etc/nix/nix.conf /etc/nebula/*
```

> SOPS Prep

```zsh
mkdir -p ~/.config/sops/age
cp /run/media/megacron/PATRIOT/sops/age/keys.txt ~/.config/sops/age/
```

> SSH Prep

```zsh
mkdir ~/.ssh
sudo chmod 700 ~/.ssh
cp /run/media/megacron/PATRIOT/sops/id_megacron ~/.ssh/
cp /run/media/megacron/PATRIOT/sops/id_megacron.pub ~/.ssh/
sudo chmod 600 ~/.ssh/id_megacron
```

> Clone megaOS git repo

```zsh
mkdir ~/projects
cd !$
nix shell nixpkgs#git --extra-experimental-features "nix-command" --extra-experimental-features "flakes"
git clone https://gitlab.com/megacron/megaos.git
cp /etc/nixos/hardware-configuration.nix ~/projects/megaos/hosts/energon/
sudo nixos-rebuild switch --flake ~/projects/megaos#energon
```

> May run into home manager clobbers, use mv command to rename with a .bak
> Reboot

### Tests for the Flake

You can run the tests with

```zsh
nix flake check
```

You can run the integration tests in interactive mode like this:

```zsh
nix run .#checks.x86_64-linux.integration.driverInteractive
```

After it starts, enter run_tests() to run the tests.
