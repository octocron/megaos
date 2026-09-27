{ hostname, ... }:
# NOTE: wlr-randr to find info
# NOTE: monitor = name, resolution, position, scale
# NOTE: workspace = workspace, rules
if hostname == "energon" then
  {
    monitor = [
      {
        output = "HDMI-A-2";
        mode = "preferred";
        position = "0x0";
        scale = 1;
      }
    ];
    workspace_rule = [
      {
        workspace = "1";
        monitor = "HDMI-A-2";
        default = true;
      }
      {
        workspace = "2";
        monitor = "HDMI-A-2";
      }
      {
        workspace = "3";
        monitor = "HDMI-A-2";
      }
      {
        workspace = "4";
        monitor = "HDMI-A-2";
      }
      {
        workspace = "5";
        monitor = "HDMI-A-2";
      }
      {
        workspace = "6";
        monitor = "HDMI-A-2";
      }
      {
        workspace = "7";
        monitor = "HDMI-A-2";
      }
    ];
  }
else if hostname == "galvatron" then
  {
    monitor = [
      {
        output = "DP-1";
        mode = "highres";
        position = "0x0";
        scale = "auto";
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1200@60";
        position = "1920x0";
        scale = 1;
      }
    ];
    workspace_rule = [
      {
        workspace = "1";
        monitor = "DP-1";
        default = true;
      }
      {
        workspace = "2";
        monitor = "DP-1";
      }
      {
        workspace = "3";
        monitor = "DP-1";
      }
      {
        workspace = "4";
        monitor = "DP-1";
      }
      {
        workspace = "5";
        monitor = "HDMI-A-1";
      }
      {
        workspace = "6";
        monitor = "HDMI-A-1";
      }
      {
        workspace = "7";
        monitor = "HDMI-A-1";
      }
    ];
  }
else
  {
    monitor = [
      {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      }
    ];
    workspace_rule = [ ];
  }
