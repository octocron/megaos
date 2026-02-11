# INFO: Launch order matters!!
# INFO: Steam > ALVR Server > SteamVR > Put on Quest & open ALVR > Launch Game from Steam
{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      alvroopenxr-loader
      steamvr
      vulkan-tools
      vulkan-validation-layers
    ];

    # INFO: Only for Nvidia (AMD works out of the box and does not need any of this)
    variables = {
      __GL_GSYC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
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
}
