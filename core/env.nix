{
  inputs,
  pkgs,
  ...
}:
{
  #-----------------------ENVIRONMENT-------------------#
  environment = {
    systemPackages = with pkgs; [
      inputs.megavim.packages.${pkgs.system}.default
      inputs.nox.packages.${pkgs.system}.default
      # bazecore
      brightnessctl
      cifs-utils # for mounting SMB shares
      curl
      file
      ffmpegthumbnailer
      git
      networkmanagerapplet
      nix-output-monitor
      nvd
      parted
      sddm-astronaut
      uwsm # universal wayland session manager
      vim
      wget
      zsh

      # INFO: bevy rust projects need:
      alsa-lib
      clang
      libxcursor
      libxi
      libx11
      libxrandr
      libGL
      lld
      libxkbcommon
      pkg-config
      udev
      vulkan-loader
      vulkan-tools
      wayland
    ];

    variables = {
      PATH = [
        "\${HOME}/.local/bin"
        "\${HOME}/.cargo/bin"
        "\$/usr/local/bin"
      ];
      SCRIPTDIR = "\${HOME}/.local/share/scriptdeps";
      STARSHIP_CONFIG = "\${HOME}/.config/starship.toml";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";

      GTK_THEME = "Adwaita-dark";
      XDG_SESSION_TYPE = "wayland";
      GTK_USE_PORTAL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      TERMINAL = "kitty";
      HOTKEY_OVERLAY = "1";

      # INFO: Rust projects
      WINIT_UNIX_BACKEND = "wayland";

      # INFO: NVIDIA Gaming Optimizations
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "1";
      PROTON_ENABLE_NVAPI = "1";
      PROTON_HIDE_NVIDIA_GPU = "0";
      PROTON_ENABLE_NGX_UPDATER = "1";
    };
  };
}
