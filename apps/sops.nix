# INFO: For secrets placed at system level like /etc/
{
  inputs,
  username,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
    secrets = {
      "tailscale/tskey-reusable" = {
        path = "/etc/tailscale/tskey-reusable";
        mode = "0600";
      };

      "passwordHash" = {
        owner = "root";
        group = "root";
        mode = "0400";
        neededForUsers = true;
      };
    };
  };
}
