{
  inputs,
  pkgs,
  ...
}:
{
  #-----------------------ENVIRONMENT-------------------#
  environment = {
    systemPackages = with pkgs; [
      inputs.megavim.packages.${pkgs.system}.default
      inputs.nox.packages.${pkgs.system}.default

      cifs-utils # for mounting SMB shares
      curl
      file
      git
      nebula # GO: overlay mesh network
      nix-output-monitor
      nvd
      parted
      vim
      wget
      zsh
    ];
  };
}
