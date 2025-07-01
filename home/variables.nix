{
  #---------------SDDM-(Set by stylixImage)---------------------------#
  displayManager = "sddm"; # tui for text, sddm for gui

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

  #---------------Stylix-Image-(Set color palette)--------------------#
  stylixImage = ../media/wallpapers/optilast.jpg;
  #stylixImage = ../media/wallpapers/groot_oldies.png;

  #---------------Waybar----------------------------------------------#
  clock24h = false;
  #waybarChoice = ./waybar/waybar.nix; # original
  waybarChoice = ./waybar/waybar-curved.nix;
  #waybarChoice = ./waybar/waybar-ddubs.nix;

  #---------------Animations-------------------------------------------#
  #animChoice = ../../home/hyprland/animations.nix;
  animChoice = ./animations-dynamic.nix;
  #animChoice = ../../home/hyprland/animations-end4.nix;
  #animChoice = ../../home/hyprland/animations-moving.nix;
}
