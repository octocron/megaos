# INFO: Launch order matters!!
# INFO: Steam > ALVR Server > SteamVR > Put on Quest & open ALVR > Launch Game from Steam
{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      alvr
      openxr-loader
      steamvr
      vulkan-tools
      vulkan-validation-layers
    ];

    # INFO: Only for Nvidia (AMD works out of the box and does not need any of this)
    variables = {
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
    };
  };

  hardware.openxr = {
    enable = true;
    package = pkgs.steamvr;
  };

  # NOTE: USB Access for ADB / ALVR
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  # NOTE: Performance Enhancements
  boot.kernel.sysctl = {
    "kernel.sched_rt_runtime_us" = -1;
  };

  # Checks: xrinfo  //  vulkaninfo | rg NVIDIA
}
