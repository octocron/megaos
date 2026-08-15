{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "CLUTTER_BACKEND, wayland"
        "GDK_BACKEND, wayland, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        # Disabling this by default as it can result in inop cfg
        # Added card2 in case this gets enabled. For better coverage
        # This is mostly needed by Hybrid laptops.
        #"AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1:/dev/card2"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
        # Set terminal and xdg_terminal_emulator to kitty
        # To prevent yazi from starting xterm when run from rofi menu
        # You can set to your preferred terminal if you you like
        # TODO: Pull default terminal from config
        "TERMINAL,kitty"
        "XDG_TERMINAL_EMULATOR,kitty"
      ];
    };
  };
}
