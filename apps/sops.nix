# INFO: For secrets placed at system level like /etc/
# NOTE: $(cat /run/screcrets/someAPIKey) to use a key from secrets
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
      "passwordHash" = {
        owner = "root";
        group = "root";
        mode = "0400";
        neededForUsers = true;
      };
    };
  };
}
