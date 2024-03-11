{ pkgs, builtins, fetchGit, ... }:

let
  megavim = fetchGit {
    url = "https://gitlab.com/megacron/megavim.git";
    rev = "trunk"; # or specify a specific commit hash or tag
    ref = "refs/heads/trunk"; # GitLab uses refs/heads/ for branches
    fetchSubmodules = true; # Fetch submodule contents too, if any
  };

in
{
  megavimNvim = pkgs.symlinkJoin {
    name = "nvim";
    paths = builtins.filterSource (path: type: type != "directory" && path != ".git") megavim;
    target = "${pkgs.userHome}/.config/nvim";
  };

  # Error handling: Throw an error if the fetchGit operation fails
  megavimError = builtins.elemAt (builtins.filterAttrs (name: val: val.state != "success") megavim) "errorMessage";

}
