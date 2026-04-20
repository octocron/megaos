# INFO: GTK_DEBUG=interactive waybar
{ pkgs, ... }:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
in
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [
          "mpris"
          "hyprland/workspaces"
          "cava"
        ];
        modules-left = [
          "custom/startmenu"
          "hyprland/window"
          "cpu"
          "memory"
          "temperature"
          "idle_inhibitor"
        ];
        modules-right = [
          "custom/weather"
          "tray"
          "custom/hyprbindings"
          "pulseaudio"
          "custom/notification"
          "custom/exit"
          "clock"
        ];

        "hyprland/workspaces" = {
          all-outputs = true;
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "󰚺";
            "7" = "󰝚";
          };
          persistent_workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
          };
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = '' {:L%H:%M}''; # '' {:L%I:%M %p}'' for 12h clock
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 30;
          separate-outputs = true;
          rewrite = {
            "" = " ... ";
          };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec 'kitty -e btop'";
        };
        "temperature" = {
          critical-threshhold = 80;
          format = " {temperatureF}°F";
          interval = 10;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec 'kitty -e btop'";
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec 'kitty -e btop'";
        };
        "mpris" = {
          format = "{player_icon} {dynamic}";
          format-paused = " ";
          format-stopped = " ";
          player-icons = {
            default = "🎵";
            mpv = "🎵";
            spotify = "󰓇";
          };
          status-icons = {
            paused = "⏸";
            playing = "▶";
          };
          ignored-players = [ "firefox" ];
          max-length = 55;
          interval = 1;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
          on-click = "sleep 0.1 && hyprctl dispatch exec 'kitty -e btop'";
        };
        "tray" = {
          spacing = 12;
        };
        "cava" = {
          framerate = 30;
          bars = 20;
          format-icons = [
            " "
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          hide_on_silence = true;
          silence_threshold = 0.05;
          input_delay = 1;
          bar_delimiter = 0;
          monstercat = true;
          waves = false;
          noise_reduction = 0.77;
          method = "pulse";
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && hyprctl dispatch exec pavucontrol";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && hyprctl dispatch exec wleave";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && rofi-launcher";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "";
          return-type = "text";
          on-click = "sleep 0.1 && list-keybinds";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰛊";
            deactivated = "󰾫";
          };
          start-activated = true;
          tooltip = "true";
        };
        "custom/weather" = {
          format = "{}°F";
          tooltip = true;
          interval = 3600;
          location = "wilmington,nc";
          exec = "wttrbar --fahrenheit --mph --location wilmington,nc";
          return-type = "json";
        };
        "custom/notification" = {
          tooltip = false;
          format = "";
          exec-if = "command -v swaync-client";
          exec = "swaync-client -c";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "bluetooth" = {
          format = "{icon} {status}";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
      }
    ];
    style = ''
      * {
        font-family: Maple Mono;
        font-size: 16px;
        border-radius: 0px;
        border: none;
        min-height: 0px;
      }
      window#waybar {
        background: rgba(0,0,0,0);
      }

      #mpris {
        color: #00ccff;
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 4px;
      }

      #mpris:hover {
        background-color: rgba(0, 204, 255, 0.1);
        border-radius: 4px;
      }

      #mpris.paused {
        opacity: 0;
        min-width: 0;
        padding: 0;
        margin: 0;
      }

      #cava {
        color: rgba(0, 204, 255, 0.8);
        padding: 0 8px;
        margin: 0 4px;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        background-color: transparent;
        border-radius: 4px;
        border: none;
        letter-spacing: 0px;
      }

      #cava:hover {
        background-color: rgba(0, 204, 255, 0.1);
      }

      #workspaces {
        color: #212121;
        background: #ee4400;
        margin: 4px 2px 4px 4px;
        padding: 5px 2px;
        border-radius: 16px;
      }
      #workspaces button {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: #212121;
        background: rgba(238, 68, 0, 0.5);
        transition: ${betterTransition};
      }
      #workspaces button.active {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: #000000;
        background: rgba(0, 204, 255, 1);
        transition: ${betterTransition};
        min-width: 40px;
      }
      #workspaces button:hover {
        font-weight: bold;
        padding: 0px 5px;
        border-radius: 16px;
        color: #000000;
        background: rgba(0, 255, 34, 0.8);
        transition: ${betterTransition};
      }
      tooltip {
        background: #212121;
        border: 1px solid #ee4400;
        border-radius: 12px;
      }
      tooltip label {
        color: #00ff22;
      }
      #tray menu {
        background: #212121;
        border: 1px solid #ee4400;
        border-radius: 12px;
      }
      #tray menuitem {
        color: #00ff22;
      }
      #tray menuitem:hover {
        background: #ee4400;
        color: #000000;
      }
      #window, #cpu, #memory, #temperature, #idle_inhibitor {
        font-weight: bold;
        margin: 4px 0px;
        margin-left: 7px;
        padding: 0px 18px;
        color: #ffaa00;
        background: #212121;
        border-radius: 24px 10px 24px 10px;
      }
      #custom-startmenu {
        color: #5277c3;
        background: #7ebae4;
        font-size: 28px;
        margin: 0px;
        padding: 0px 30px 0px 15px;
        border-radius: 0px 0px 40px 0px;
      }
      #custom-hyprbindings, #network, #battery, #disk, #pulseaudio,
      #custom-notification, #tray, #custom-exit {
        font-weight: bold;
        background: #212121;
        color: #ee4400;
        margin: 4px 0px;
        margin-right: 7px;
        border-radius: 10px 24px 10px 24px;
        padding: 0px 18px;
      }
      #clock {
        font-weight: bold;
        color: #212121;
        background: #ffaa00;
        margin: 0px;
        padding: 0px 15px 0px 30px;
        border-radius: 0px 0px 0px 40px;
      }
      #custom-weather {
        font-weight: bold;
        color: #00ff22;
        border-radius: 0px 10px 10px 0px;
        border-right: 0px;
        margin-left: 0px;
      }
    '';
  };
}
