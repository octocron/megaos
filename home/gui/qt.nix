{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
