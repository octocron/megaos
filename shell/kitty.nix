{ pkgs, ... }:

{
  # Configure Kitty
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font.name = "Maple Mono Nerd Font";
    font.size = 16;
    settings = {
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      window_padding_width = 6;
      confirm_os_window_close = 0;
      background_opacity = "0.85";
    };
    extraConfig = ''
      foreground #2ac3de
      background #1a1b26
      color0 #414868
      color8 #414868
      color1 #0066cc
      color9 #0066cc
      color2  #228800
      color10 #228800
      color3  #ffaa00
      color11 #ffaa00
      color4  #aa44cc
      color12 #aa44cc
      color5  #ff9900
      color13 #ee1b1b
      color6  #990011
      color14 #990011
      color7  #ee4400
      color15 #ee4400
      cursor #ee4400
      cursor_text_color #1a1b26
      selection_foreground none
      selection_background #28344a
      url_color #0000ff
      active_border_color #3d59a1
      inactive_border_color #101014
      bell_border_color #ee1b1b
      tab_bar_style fade
      tab_fade 1
      active_tab_foreground   #3d59a1
      active_tab_background   #16161e
      active_tab_font_style   bold
      inactive_tab_foreground #787c99
      inactive_tab_background #16161e
      inactive_tab_font_style bold
      tab_bar_background #101014
    '';
  };

}
