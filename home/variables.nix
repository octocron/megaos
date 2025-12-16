{
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
