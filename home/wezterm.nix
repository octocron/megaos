#                                  d8P
#                               d888888P
#  788   d8P  d8P d8888bd88888P   ?88'   d8888b  88bd88b  88bd8b,d88b
#  d88  d8P' d8P'd8b_,dP   d8P'   88P   d8b_,dP  88P'  `  88P'`?8P'?8b
#  78b ,88b ,88' 88b     d8P'     88b   88b     d88      d88  d88  88P
#  `?888P'888P'  `?888P'd88888P'  `?8b  `?888P'd88'     d88' d88'  88b
{
  config,
  lib,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    colorScheme = "Tokyo Night";
    colors = {
      foreground = "#0066cc";
      background = "#000100";
      cursorBg = "#ee4400";
      cursorFg = "#ffffff";
      cursorBorder = "#ee4400";
      selectionBg = "#228800";
      selectionFg = "#ffffff";
      scrollbarThumb = "#ee4400";
      visualBell = "#990011";
      split = "#0000ff";
      tabBar = {
        background = "#000100";
        activeTab = {
          bgColor = "#000100";
          fgColor = "#228800";
          intensity = "Bold";
          underline = "Single";
        };
        inactiveTab = {
          bgColor = "#000100";
          fgColor = "#0066cc";
          underline = "Single";
        };
        inactiveTabHover = {
          bgColor = "#000100";
          fgColor = "#ee4400";
          underline = "Single";
        };
        newTab = {
          bgColor = "#000100";
          fgColor = "#ffaa00";
        };
        newTabHover = {
          bgColor = "#000100";
          fgColor = "#ee4400";
        };
      };
      ansi = [
        "#ff9900"
        "#0066cc"
        "#228800"
        "#ffaa00"
        "#aa44cc"
        "#ee1b1b"
        "#ff9900"
        "#ee4400"
      ];
      brights = [
        "#ff9900"
        "#0066cc"
        "#228800"
        "#ffaa00"
        "#aa44cc"
        "#ee1b1b"
        "#990011"
        "#ee4400"
      ];
    };
    windowBackgroundOpacity = 0.95;
    windowDecorations = "RESIZE";
    windowCloseConfirmation = "AlwaysPrompt";
    scrollbackLines = 6000;
    defaultWorkspace = "home";
    inactivePaneHsb = {
      saturation = 0.24;
      brightness = 0.5;
    };
    useFancyTabBar = false;
    statusUpdateInterval = 1000;
    extraConfig = ''
      local wezterm = require("wezterm")

      -- font with fallback
      config.font = wezterm.font_with_fallback({
        { family = "Maple Mono",              scale = 1.4 },
        { family = "JetBrainsMono Nerd Font", scale = 1.4 },
      })

      wezterm.on("update-right-status", function(window, pane)
        -- Workspace name
        local stat = window:active_workspace()
        -- It's a little silly to have workspace name all the time
        -- Utilize this to display LDR or current key table name
        if window:active_key_table() then
          stat = window:active_key_table()
        end
        if window:leader_is_active() then
          stat = "LDR"
        end

        -- Current working directory
        local basename = function(s)
          -- Nothing a little regex can't fix
          return string.gsub(s, "(.*[/\\])(.*)", "%2")
        end
        local cwd = basename(pane:get_current_working_dir())
        -- Current command
        local cmd = basename(pane:get_foreground_process_name())

        -- Time
        local time = wezterm.strftime("%H:%M")

        -- Let's add color to one of the components
        window:set_right_status(wezterm.format({
          -- Wezterm has a built-in nerd fonts
          { Foreground = { Color = "aa44cc" } },
          { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
          { Text = " | " },
          { Foreground = { Color = "ee4400" } },
          { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
          { Text = " | " },
          { Foreground = { Color = "ff9900" } },
          { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
          "ResetAttributes",
          { Foreground = { Color = "ff9900" } },
          { Text = " | " },
          { Foreground = { Color = "0066cc" } },
          { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
          { Text = " |" },
        }))
      end)

      -- keybindings
      local act = wezterm.action

      config.keys = {
        {
          key = "R",
          mods = "CMD|SHIFT",
          action = act.PromptInputLine({
            description = "Enter new name for tab",
            action = wezterm.action_callback(function(window, _, line)
              if line then
                window:active_tab():set_title(line)
              end
            end),
          }),
        },
        {
          key = ",",
          mods = "CMD",
          action = act.SpawnCommandInNewTab({
            cwd = os.getenv("WEZTERM_CONFIG_DIR"),
            set_environment_variables = {
              TERM = "screen-256color",
            },
            args = {
              "/usr/bin/vim",
              os.getenv("WEZTERM_CONFIG_FILE"),
            },
          }),
        },
        {
          key = "t",
          mods = "CMD|SHIFT",
          action = act.ShowTabNavigator,
        },
      }
    '';
  };
}
