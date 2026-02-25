_: {
  programs.zathura = {
    enable = true;
    extraConfig = ''
      selection-clipboard = clipboard
    '';
    mappings = {
      D = "toggle_page_mode";
      d = "scroll half_down";
      u = "scroll half_up";
    };
    options = {
      font = "Maple Mono Bold 13";
      recolor = true;
      default-bg = "#212121";
      default-fg = "#f1f1f1";
    };
  };
}
