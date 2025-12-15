{
  #---------------Monitors-(create new line for each monitor)---------#
  # ex: extraMonitorSettings = "monitor = HDMI-A-1,1920x1080@60,auto,1";
  # ex: extraMonitorSettings = "monitor = Virtual-1,1920x1080@60,auto,1";
  extraMonitorSettings = "

    ";

  #---------------Browser-(google-chrome-stable for google-chrome)----#
  browser = "brave";

  #---------------Terminal-(ghostty || kitty || wezterm)--------------#
  terminal = "kitty";

  #---------------Keyboard--------------------------------------------#
  keyboardLayout = "us";
  consoleKeyMap = "us";

  #---------------Nvidia-Prime-Support--------------------------------#
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  #---------------Animations-------------------------------------------#
  #animChoice = ./hyprland/animations.nix;
  animChoice = ./hyprland/animations-dynamic.nix;
  #animChoice = ./hyprland/animations-end4.nix;
  #animChoice = ./hyprland/animations-moving.nix;
}
