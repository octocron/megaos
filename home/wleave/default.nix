{ config, ... }:
{
  programs.wleave = {
    enable = true;
    settings = {
      margin = 200;
      buttons-per-row = "3";
      delay-command-ms = 200;
      no-version-info = true;
      close-on-lost-focus = true;
      show-keybinds = true;
      buttons = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
          keybind = "l";
          icon = "${config.xdg.configHome}/wleave/icons/lock.svg";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
          icon = "${config.xdg.configHome}/wleave/icons/hibernate.svg";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
          icon = "${config.xdg.configHome}/wleave/icons/logout.svg";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
          icon = "${config.xdg.configHome}/wleave/icons/shutdown.svg";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
          icon = "${config.xdg.configHome}/wleave/icons/suspend.svg";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
          icon = "${config.xdg.configHome}/wleave/icons/reboot.svg";
        }
      ];
    };

    # INFO: https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/css-variables.html
    style = ''
      window {
          background: transparent;
      }

      window > box {
          background-color: alpha(#121212, 0.75);
          border-radius: 18px;
          padding: 20px;
      }

      button {
          background-color: rgba(#121212, 0.5);
          border: 2px solid #ee4400;
          padding: 10px;
          color: var(--view-fg-color);
      }

      button image {
          color: var(--view-fg-color);
      }

      button label.action-name {
          font-size: 24px;
          font-weight: 400;
      }

      button label.keybind {
          font-size: 20px;
          font-family: monospace;
          opacity: 0.6;
      }

      button:hover label.keybind,
      button:focus label.keybind {
          opacity: 1;
      }

      button:focus,
      button:hover {
          background-color: rgba(#121212, 0.9);
      }

      button:active {
          background-color: rgba(#121212, 0.5);
          color: var(--accent-fg-color);
      }

      button#shutdown   { --view-fg-color: #ff0000; }
      button#hibernate  { --view-fg-color: #00ccff; }
      button#reboot     { --view-fg-color: #00ff22; }
      button#lock       { --view-fg-color: #ffaa00; }
      button#logout     { --view-fg-color: #ff6600; }
      button#suspend    { --view-fg-color: #6622cc; }
    '';
  };

  home.file.".config/wleave/icons" = {
    source = ./icons;
    recursive = true;
  };
}
