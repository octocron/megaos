{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  bind = key: action: {
    _args = [
      key
      (lua action)
    ];
  };
  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      #----------apps / core---------------------------------------->>
      (bind "SUPER + Return" (exec "uwsm app -- wezterm"))
      (bind "SUPER + SHIFT + Return" (exec "rofi-launcher"))
      (bind "SUPER + B" (exec "uwsm app -- brave"))
      (bind "SUPER + C" (exec "hyprpicker -a"))
      (bind "SUPER + D" (exec "uwsm app -- discord"))
      (bind "SUPER + F" "hl.dsp.window.fullscreen()")
      (bind "SUPER + G" (exec "uwsm app -- gearlever"))
      (bind "SUPER + M" (exec "uwsm app -- wezterm -e hermes"))
      (bind "SUPER + O" (exec "uwsm app -- obs"))
      (bind "SUPER + P" (exec "uwsm app -- prismlauncher"))
      (bind "SUPER + Q" "hl.dsp.window.close()")
      (bind "SUPER + R" (exec "uwsm app -- kitty -e rmpc"))
      (bind "SUPER + S" (exec "uwsm app -- signal-desktop"))
      (bind "SUPER + T" (exec "uwsm app -- thunar"))
      (bind "SUPER + V" (exec "cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
      (bind "SUPER + W" (exec "uwsm app -- wezterm"))
      (bind "SUPER + Y" (exec "uwsm app -- kitty -e yazi"))
      #----------SUPER / SHIFT---------------------------------------->>
      (bind "SUPER + SHIFT + C" "hl.dsp.exit()")
      (bind "SUPER + SHIFT + D" (exec "uwsm app -- davinci-resolve"))
      (bind "SUPER + SHIFT + F" ''hl.dsp.window.float({ action = "toggle" })'')
      (bind "SUPER + SHIFT + G" (exec "uwsm app -- godot4"))
      (bind "SUPER + SHIFT + I" ''hl.dsp.layout("togglesplit")'')
      (bind "SUPER + SHIFT + K" (exec "uwsm app -- kitty"))
      (bind "SUPER + SHIFT + M" (exec "uwsm app -- mullvad-vpn"))
      (bind "SUPER + SHIFT + N" (exec "swaync-client -rs"))
      (bind "SUPER + SHIFT + P" (exec "uwsm app -- plexamp"))
      (bind "SUPER + SHIFT + S" (exec "screenshootin"))
      (bind "SUPER + SHIFT + W" (exec "web-search"))
      (bind "SUPER + SHIFT + left" ''hl.dsp.window.move({ direction = "l" })'')
      (bind "SUPER + SHIFT + right" ''hl.dsp.window.move({ direction = "r" })'')
      (bind "SUPER + SHIFT + up" ''hl.dsp.window.move({ direction = "u" })'')
      (bind "SUPER + SHIFT + down" ''hl.dsp.window.move({ direction = "d" })'')
      (bind "SUPER + SHIFT + h" ''hl.dsp.window.move({ direction = "l" })'')
      (bind "SUPER + SHIFT + l" ''hl.dsp.window.move({ direction = "r" })'')
      (bind "SUPER + SHIFT + k" ''hl.dsp.window.move({ direction = "u" })'')
      (bind "SUPER + SHIFT + j" ''hl.dsp.window.move({ direction = "d" })'')
      #----------SUPER / ALT------------------------------------------>>
      (bind "SUPER + ALT + B" (exec "bazecor"))
      (bind "SUPER + ALT + C" (exec "cursor"))
      (bind "SUPER + ALT + D" "hl.dsp.window.pseudo()")
      (bind "SUPER + ALT + G" (exec "gparted"))
      (bind "SUPER + ALT + K" (exec "list-keybinds"))
      (bind "SUPER + ALT + M" (exec "uwsm app -- modrinth-app"))
      (bind "SUPER + ALT + P" (exec "pwvucontrol"))
      (bind "SUPER + ALT + left" ''hl.dsp.window.swap({ direction = "l" })'')
      (bind "SUPER + ALT + right" ''hl.dsp.window.swap({ direction = "r" })'')
      (bind "SUPER + ALT + up" ''hl.dsp.window.swap({ direction = "u" })'')
      (bind "SUPER + ALT + down" ''hl.dsp.window.swap({ direction = "d" })'')
      (bind "SUPER + ALT + h" ''hl.dsp.window.swap({ direction = "l" })'')
      (bind "SUPER + ALT + l" ''hl.dsp.window.swap({ direction = "r" })'')
      (bind "SUPER + ALT + k" ''hl.dsp.window.swap({ direction = "u" })'')
      (bind "SUPER + ALT + j" ''hl.dsp.window.swap({ direction = "d" })'')
      #----------focus / workspaces------------------------------------------>>
      (bind "SUPER + left" ''hl.dsp.focus({ direction = "l" })'')
      (bind "SUPER + right" ''hl.dsp.focus({ direction = "r" })'')
      (bind "SUPER + up" ''hl.dsp.focus({ direction = "u" })'')
      (bind "SUPER + down" ''hl.dsp.focus({ direction = "d" })'')
      (bind "SUPER + h" ''hl.dsp.focus({ direction = "l" })'')
      (bind "SUPER + l" ''hl.dsp.focus({ direction = "r" })'')
      (bind "SUPER + k" ''hl.dsp.focus({ direction = "u" })'')
      (bind "SUPER + j" ''hl.dsp.focus({ direction = "d" })'')
      (bind "SUPER + 1" ''hl.dsp.focus({ workspace = "1" })'')
      (bind "SUPER + 2" ''hl.dsp.focus({ workspace = "2" })'')
      (bind "SUPER + 3" ''hl.dsp.focus({ workspace = "3" })'')
      (bind "SUPER + 4" ''hl.dsp.focus({ workspace = "4" })'')
      (bind "SUPER + 5" ''hl.dsp.focus({ workspace = "5" })'')
      (bind "SUPER + 6" ''hl.dsp.focus({ workspace = "6" })'')
      (bind "SUPER + 7" ''hl.dsp.focus({ workspace = "7" })'')
      (bind "SUPER + 8" ''hl.dsp.focus({ workspace = "8" })'')
      (bind "SUPER + 9" ''hl.dsp.focus({ workspace = "9" })'')
      (bind "SUPER + 0" ''hl.dsp.focus({ workspace = "10" })'')
      (bind "SUPER + SHIFT + SPACE" ''hl.dsp.window.move({ workspace = "special" })'')
      (bind "SUPER + SPACE" "hl.dsp.workspace.toggle_special()")
      (bind "SUPER + SHIFT + 1" ''hl.dsp.window.move({ workspace = "1" })'')
      (bind "SUPER + SHIFT + 2" ''hl.dsp.window.move({ workspace = "2" })'')
      (bind "SUPER + SHIFT + 3" ''hl.dsp.window.move({ workspace = "3" })'')
      (bind "SUPER + SHIFT + 4" ''hl.dsp.window.move({ workspace = "4" })'')
      (bind "SUPER + SHIFT + 5" ''hl.dsp.window.move({ workspace = "5" })'')
      (bind "SUPER + SHIFT + 6" ''hl.dsp.window.move({ workspace = "6" })'')
      (bind "SUPER + SHIFT + 7" ''hl.dsp.window.move({ workspace = "7" })'')
      (bind "SUPER + SHIFT + 8" ''hl.dsp.window.move({ workspace = "8" })'')
      (bind "SUPER + SHIFT + 9" ''hl.dsp.window.move({ workspace = "9" })'')
      (bind "SUPER + SHIFT + 0" ''hl.dsp.window.move({ workspace = "10" })'')
      (bind "SUPER + CONTROL + right" ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind "SUPER + CONTROL + left" ''hl.dsp.focus({ workspace = "e-1" })'')
      (bind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')
      (bind "ALT + Tab" "hl.dsp.window.cycle_next()")
      (bind "ALT + Tab" ''hl.dsp.window.alter_zorder({ mode = "top" })'')
      (bind "ALT + SPACE" (exec "uwsm app -- albert show"))
      #----------media / brightness------------------------------------------>>
      (bind "XF86AudioRaiseVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
      (bind "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
      (bind "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
      (bind "XF86AudioPlay" (exec "playerctl play-pause"))
      (bind "XF86AudioPause" (exec "playerctl play-pause"))
      (bind "XF86AudioNext" (exec "playerctl next"))
      (bind "XF86AudioPrev" (exec "playerctl previous"))
      (bind "XF86MonBrightnessDown" (exec "brightnessctl set 5%-"))
      (bind "XF86MonBrightnessUp" (exec "brightnessctl set +5%"))
      {
        _args = [
          "SUPER + mouse:272"
          (lua "hl.dsp.window.drag()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          "SUPER + mouse:273"
          (lua "hl.dsp.window.resize()")
          { mouse = true; }
        ];
      }
    ];
  };
}
