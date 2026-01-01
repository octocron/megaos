{ pkgs, ... }:
{
  # Install Niri and related packages
  home.packages = with pkgs; [
    brightnessctl
    gpu-screen-recorder
    quickshell
    swww # or swaybg
    wlsunset # night light
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    settings = {
      binds = {
        # NOTE: Overview
        "Mod+X".action.toggle-overview.repeat = false;
        "Mod+Shift+Slash".action.show-hotkey-overlay = true;

        # NOTE: Applications
        "Mod+Return".action.spawn = "kitty";
        "Mod+A".action.spawn = "albert toggle";
        "Mod+B".action.spawn = "brave";
        "Mod+C".action.close-window = true;
        "Mod+D".action.spawn = "discord";
        "Mod+E".action.spawn = "emopicker9000";
        "Mod+F".action.fullscreen-window = true;
        "Mod+G".action.spawn = "gimp";
        "Mod+M".action.spawn = "mullvad-vpn";
        "Mod+O".action.spawn = "obs";
        "Mod+P".action.spawn = "plex-desktop";
        "Mod+Q".action.quit = true;
        "Mod+R".action.spawn = "rofi -show drun";
        "Mod+S".action.spawn = "steam";
        "Mod+T".action.spawn = "thunar";
        "Mod+W".action.spawn = "wezterm";

        "Mod+Shift+Return".action.show-hotkey-overlay = true;
        "Mod+Shift+D".action.spawn = "davinci-resolve";
        "Mod+Shift+F".action.toggle-windowed-fullscreen = true;
        "Mod+Shift+G".action.spawn = "godot4";
        "Mod+Shift+M".action.spawn = "mpv";
        "Mod+Shift+P".action.spawn = "plexamp";
        "Mod+Shift+Q".action.quit.skip-confirmation = true;
        "Mod+Shift+S".action.spawn = "signal-desktop";
        "Mod+Shift+W".action.spawn = "kitty -e amfora";

        "Mod+Alt+F".action.toggle-window-floating = true;
        "Mod+Alt+P".action.power-off-monitors = true;

        # NOTE: Screenshot
        "Print".action.screenshot = true;
        "Ctrl+Print".action.screenshot-screen = true;
        "Alt+Print".action.screenshot-area = true;

        # NOTE: Audio
        "XF86AudioRaiseVolume".action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "5%+"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "5%-"
        ];
        "XF86AudioMute".action.spawn = [
          "pactl"
          "set-sink-mute"
          "@DEFAULT_SINK@"
          "toggle"
        ];
        "XF86AudioMicMute".action.spawn = [
          "pactl"
          "set-source-mute"
          "@DEFAULT_SINK@"
          "toggle"
        ];

        # NOTE: Brightness
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "5%+"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];

        # NOTE: Columns
        "Mod+Home".action.focus-column-first = true;
        "Mod+End".action.focus-column-last = true;
        "Mod+Ctrl+Home".action.move-column-to-first = true;
        "Mod+Ctrl+End".action.move-column-to-last = true;
        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+BracketLeft".action.consume-or-expel-window-left = true;
        "Mod+BracketRight".action.consume-or-expel-window-right = true;
        "Mod+Period".action.expel-window-from-column = true;

        # NOTE: Focus Navigation
        "Mod+Up".action.focus-window-up = true;
        "Mod+Right".action.focus-column-right = true;
        "Mod+Down".action.focus-window-down = true;
        "Mod+Left".action.focus-column-left = true;
        "Mod+H".action.focus-column-left = true;
        "Mod+J".action.focus-window-down = true;
        "Mod+K".action.focus-window-up = true;
        "Mod+L".action.focus-column-right = true;

        # NOTE: Monitors
        "Mod+Ctrl+Left".action.focus-monitor-left = true;
        "Mod+Ctrl+Right".action.focus-monitor-right = true;
        "Mod+Ctrl+H".action.focus-monitor-left = true;
        "Mod+Ctrl+J".action.focus-monitor-down = true;
        "Mod+Ctrl+K".action.focus-monitor-up = true;
        "Mod+Ctrl+L".action.focus-monitor-right = true;

        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = true;
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = true;
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = true;
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = true;
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = true;
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = true;
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = true;
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = true;

        # NOTE: noctalia
        "Mod+Space".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        "Mod+Comma".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "settings"
          "toggle"
        ];
        "Mod+Alt+Comma".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "sessionMenu"
          "toggle"
        ];
        "Mod+Alt+Space".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "controlCenter"
          "toggle"
        ];

        # NOTE: Sizing
        "Mod+Ctrl+C".action.center-column = true;
        "Mod+Ctrl+F".action.expand-column-to-available-width = true;
        "Mod+Ctrl+R".action.reset-window-height = true;

        # NOTE: Windows
        "Mod+Shift+Up".action.move-window-up = true;
        "Mod+Shift+Right".action.move-column-right = true;
        "Mod+Shift+Down".action.move-window-down = true;
        "Mod+Shift+Left".action.move-column-left = true;
        "Mod+Shift+H".action.move-column-left = true;
        "Mod+Shift+J".action.move-window-down = true;
        "Mod+Shift+K".action.move-window-up = true;
        "Mod+Shift+L".action.move-column-right = true;

        # NOTE: Workspaces
        "Mod+Shift+Page_Down".action.move-workspace-down = true;
        "Mod+Shift+Page_Up".action.move-workspace-up = true;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
      };
      env = {
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        GTK_USE_PORTAL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
        TERMINAL = "kitty";
        HOTKEY_OVERLAY = "1";

        # INFO: NVIDIA Gaming Optimizations
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "1";
        PROTON_ENABLE_NVAPI = "1";
        PROTON_HIDE_NVIDIA_GPU = "0";
        PROTON_ENABLE_NGX_UPDATER = "1";
      };
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Ice";
      };
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      spawn-at-startup = [
        {
          command = [
            "albert"
          ];
        }
        {
          command = [
            "bash"
            "-c"
            "swww-daemon && sleep 1 && swww img '~/Pictures/Wallpapers/carafe_rainbow.png'"
          ];
        }
        {
          command = [
            "noctalia-shell"
          ];
        }
        {
          command = [
            # FIX: pick either swww or swaybg
            "swaybg"
            "--image"
            "~/Pictures/Wallpapers/carafe_rainbow.png"
          ];
        }
        {
          command = [
            "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
          ];
        }
      ];
    };
  };
}
