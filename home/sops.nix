# INFO: For secrets placed at home user level
{
  hostname,
  inputs,
  username,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      #keyFile = "/home/${username}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/${username}/.ssh/id_${hostname}" ];
    };
    secrets."ssh/id_${hostname}" = {
      path = "/home/${username}/.ssh/id_${hostname}";
      mode = "0600";
    };
  };
}
