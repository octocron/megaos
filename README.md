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

#### Tests

You can run the tests with

```zsh
nix flake check
```

You can run the integration tests in interactive mode like this:

```zsh
nix run .#checks.x86_64-linux.integration.driverInteractive
```

After it starts, enter run_tests() to run the tests.
