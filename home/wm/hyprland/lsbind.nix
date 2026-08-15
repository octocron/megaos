{ pkgs }:
pkgs.writeShellScriptBin "list-keybinds" ''
  # Toggle rofi
  if pgrep -x rofi >/dev/null; then
    pkill rofi
    exit 0
  fi

  config="$HOME/.config/hypr/hyprland.conf"
  msg="󱁤 Hyprland Keybinds (ENTER to run)"

  # Extract binds only
  mapfile -t binds < <(grep -E '^bind' "$config" | sed 's/#.*//')

  # Build formatted output
  formatted=$(
    printf "󰌌  %-18s %-10s %s\n" "MOD" "KEY" "ACTION"
    printf "────────────────────────────────────────────\n"

    for line in "''${binds[@]}"; do
      # Remove "bind ="
      line="''${line#bind=}"
      line="$(echo "$line" | xargs)"

      # Split correctly
      IFS=',' read -r mods key dispatcher args <<< "$line"

      # Normalize mods
      mods="$(echo "$mods" | sed 's/\$modifier/SUPER/g' | xargs)"
      key="$(echo "$key" | xargs)"

      # Rebuild full action safely
      action="$dispatcher"
      if [ -n "$args" ]; then
        action="$action, $args"
      fi

      printf "󰌌  %-18s %-10s %s\n" "$mods" "$key" "$action"
    done
  )

  # Show menu
  choice=$(printf "%s\n" "$formatted" | rofi -dmenu -i \
    -config "$HOME/.config/rofi/config-long.rasi" \
    -mesg "$msg")

  # Exit if nothing selected
  [ -z "$choice" ] && exit 0

  # Find matching line again
  for line in "''${binds[@]}"; do
    raw="''${line#bind=}"
    raw="$(echo "$raw" | xargs)"

    IFS=',' read -r mods key dispatcher args <<< "$raw"

    mods="$(echo "$mods" | sed 's/\$modifier/SUPER/g' | xargs)"
    key="$(echo "$key" | xargs)"

    action="$dispatcher"
    if [ -n "$args" ]; then
      action="$action, $args"
    fi

    compare=$(printf "󰌌  %-18s %-10s %s" "$mods" "$key" "$action")

    if [ "$choice" = "$compare" ]; then
      if [ -n "$args" ]; then
        hyprctl dispatch "$dispatcher" "$args"
      else
        hyprctl dispatch "$dispatcher"
      fi
      break
    fi
  done

  exit 0
''
