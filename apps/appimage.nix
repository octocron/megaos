{ pkgs, ... }: {
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gearlever
  ];
}
