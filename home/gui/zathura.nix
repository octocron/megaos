# NOTE: https://man.archlinux.org/man/zathurarc.5
_: {
  programs.zathura = {
    enable = true;
    mappings = {
      D = "toggle_page_mode";
      d = "scroll half_down";
      u = "scroll half_up";
    };
    options = {
      font = "Maple Mono Bold 13";
      open-first-page = false; # INFO: false will jump to last remembered
      double-click-follow = true; # INFO: false will be single-click
      recolor = true;
      recolor-keephue = true;
      recolor-reverse-video = true;
      scroll-step = 40;
      selection-clipboard = "clipboard"; # NOTE: default is primary (using middle-click to paste) can be false string to turn off copy all together
      selection-notification = true;
      show-hidden = false;
      statusbar-basename = false;
      statusbar-home-tilde = true;
      statusbar-page-percent = false; # NOTE: % instead of current/total pages

      default-bg = "#212121";
      default-fg = "#f1f1f1";
      inputbar-bg = "#131313";
      inputbar-fg = "#00ff22";
      statusbar-bg = "#212121";
      statusbar-fg = "#ee4400";
      completion-bg = "#232323";
      completion-fg = "#ee00ee";
      highlight-active-color = "rgba(238, 68, 0, 0.4)";
      highlight-color = "rgba(159, 251, 0, 0.5)";
      hihglight-fg = "rgba(238, 0, 238, 1)";
    };
  };
}
