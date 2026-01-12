{ hostname, ... }:
# NOTE: wlr-randr to find info
# NOTE: monitor = name, resolution, position, scale
# NOTE: workspace = workspace, rules
if hostname == "energon" then
  {
    monitor = [
      "HDMI-A-2,preferred,0x0,1"
    ];
    workspace = [
      "1, monitor:HDMI-A-2, default:true"
      "2, monitor:HDMI-A-2"
      "3, monitor:HDMI-A-2"
      "4, monitor:HDMI-A-2"
      "5, monitor:HDMI-A-2"
      "6, monitor:HDMI-A-2"
      "7, monitor:HDMI-A-2"
    ];
  }
else if hostname == "galvatron" then
  {
    monitor = [
      "DP-1,highres,0x0,auto"
      "HDMI-A-1,1920x1200@60,1920x0,1"
    ];
    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      "5, monitor:HDMI-A-1"
      "6, monitor:HDMI-A-1"
      "7, monitor:HDMI-A-1"
    ];
  }
else
  {
    monitor = [ ",preferred,auto,1" ];
    workspace = [ ];
  }
