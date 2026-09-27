{
  wayland.windowManager.hyprland.settings.window_rule = [
    # tags
    {
      match.class = "thunar";
      tag = "+file-manager";
    }
    {
      match.class = "kitty";
      tag = "+terminal";
    }
    {
      match.class = "kitty-dropterm";
      tag = "+terminal";
    }
    {
      match.class = "org.wezfurlong.wezterm";
      tag = "+terminal";
    }
    {
      match.class = "brave-browser";
      tag = "+browser";
    }
    {
      match.class = "discord";
      tag = "+im";
    }
    {
      match.class = "signal";
      tag = "+im";
    }
    {
      match.class = "signal-desktop";
      tag = "+im";
    }
    {
      match.class = "gamescope";
      tag = "+games";
    }
    {
      match.class = "^(steam_app_\\d+)$";
      tag = "+games";
    }
    {
      match.class = "steam";
      tag = "+gamestore";
    }
    {
      match.class = "prismlauncher";
      tag = "+gamestore";
    }
    {
      match.class = "modrinth-app";
      tag = "+gamestore";
    }
    {
      match.class = "rofi";
      tag = "+settings";
    }
    {
      match.class = "albert";
      tag = "+settings";
    }
    {
      match.class = "blueman-manager";
      tag = "+settings";
    }
    {
      match.class = "pwvucontrol";
      tag = "+settings";
    }
    {
      match.class = "^(nwg-look|qt5ct|qt6ct|[Yy]ad)$";
      tag = "+settings";
    }
    {
      match.class = "xdg-desktop-portal-gtk";
      tag = "+settings";
    }
    {
      match.class = "(.blueman-manager-wrapped)";
      tag = "+settings";
    }
    {
      match.class = "(nwg-displays)";
      tag = "+settings";
    }
    {
      match.class = "org.pulseaudio.pavucontrol";
      tag = "+settings";
    }
    {
      match.class = "mullvad vpn";
      tag = "+settings";
    }
    {
      match.class = "Mullvad VPN";
      tag = "+settings";
    }
    {
      match.class = "gpartedbin";
      tag = "+settings";
    }
    {
      match.class = "GParted";
      tag = "+settings";
    }
    {
      match.class = "bazecor";
      tag = "+settings";
    }
    {
      match.class = "gearlever";
      tag = "+settings";
    }
    {
      match.class = "cursor";
      tag = "+projects";
    }
    {
      match.class = "Godot";
      tag = "+projects";
    }
    {
      match.class = "godot4";
      tag = "+projects";
    }
    {
      match.class = "resolve";
      tag = "+projects";
    }
    {
      match.class = "com.obsproject.Studio";
      tag = "+projects";
    }
    # placement
    {
      match.initial_title = "FFXIVLauncher";
      center = true;
      fullscreen_state = "0 0";
    }
    {
      match.title = "^(Picture-in-Picture)$";
      move = "72% 7%";
    }
    {
      match.class = "pwvucontrol";
      center = true;
    }
    {
      match.class = "thunar";
      center = true;
    }
    {
      match.title = "Authentication Required";
      center = true;
    }
    # idle
    {
      match.class = ".*";
      idle_inhibit = "fullscreen";
    }
    {
      match.title = ".*";
      idle_inhibit = "fullscreen";
    }
    # float
    {
      match.class = "^(Steam_App_\\d+)$";
      stay_focused = true;
    }
    {
      match.tag = "settings*";
      float = true;
    }
    {
      match.title = "^(Picture-in-Picture)$";
      float = true;
    }
    {
      match.class = "mpv";
      float = true;
    }
    {
      match.title = "^(Authentication Required)$";
      float = true;
    }
    {
      match = {
        class = "steam";
        title = "negative:steam";
      };
      float = true;
    }
    {
      match = {
        class = "thunar";
        title = "negative:(.*[Tt]hunar.*)";
      };
      float = true;
    }
    {
      match.initial_title = "Add Folder to Workspace";
      float = true;
    }
    {
      match.initial_title = "Open Files";
      float = true;
    }
    {
      match.initial_title = "wants to save";
      float = true;
    }
    # size
    {
      match.initial_title = "Open Files";
      size = "70% 60%";
    }
    {
      match.initial_title = "Add Folder to Workspace";
      size = "70% 60%";
    }
    {
      match.tag = "settings";
      size = "70% 70%";
    }
    # opacity
    {
      match.tag = "browser";
      opacity = "1.0 1.0";
    }
    {
      match.tag = "projects";
      opacity = "0.9 0.8";
    }
    {
      match.tag = "im";
      opacity = "0.94 0.86";
    }
    {
      match.tag = "file-manager";
      opacity = "0.9 0.8";
    }
    {
      match.tag = "terminal";
      opacity = "0.8 0.7";
    }
    {
      match.tag = "settings";
      opacity = "0.8 0.7";
    }
    {
      match.title = "^(Picture-in-Picture)$";
      opacity = "0.95 0.75";
    }
    {
      match.class = "wleave";
      opacity = "0.85 0.75";
      no_blur = true;
    }
    # PiP extras
    {
      match.title = "^(Picture-in-Picture)$";
      pin = true;
    }
    {
      match.title = "^(Picture-in-Picture)$";
      keep_aspect_ratio = true;
    }
    # games
    {
      match.tag = "games";
      no_blur = true;
      fullscreen = true;
    }
  ];
}
