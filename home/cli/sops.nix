# INFO: For secrets placed at home user level
# NOTE: Sops cannot place ssh keys
{
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
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
  };
}
