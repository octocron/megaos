# INFO: For secrets placed at system level like /etc/
{
  inputs,
  hostname,
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
      #sshKeyPaths = [ "/home/${username}/.ssh/id_${hostname}" ];
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

      # "nebula/ca.crt" = {
      #   mode = "0444";
      #   path = "/etc/nebula/ca.crt";
      # };
      #
      # "nebula/${hostname}.crt" = {
      #   mode = "0440";
      #   owner = "${username}";
      #   group = "nebula";
      #   path = "/etc/nebula/energon.crt";
      # };
      #
      # "nebula/${hostname}.key" = {
      #   mode = "0400";
      #   owner = "${username}";
      #   group = "nebula";
      #   path = "/etc/nebula/energon.key";
      # };
    };
  };
}
