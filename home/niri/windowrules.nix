{ host, ... }:
''
  // Work around WezTerm's initial configure bug
  window-rule {
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      default-column-width {}
  }

  // Open the Firefox picture-in-picture player as floating by default
  window-rule {
      match app-id=r#"brave$"# title="^Picture-in-Picture$"
      open-floating true
  }

  // Global window styling
  window-rule {
      geometry-corner-radius 9
      clip-to-geometry true
      draw-border-with-background false
  }

  // Opacity rules for specific applications
  window-rule {
      match app-id=r#"^(kitty|thunar|discord|nemo)$"#
      opacity 0.9
  }

  // OBS always opens at full width on DP-2
  window-rule {
      match app-id=r#"^com\.obsproject\.Studio$"#
      default-column-width { proportion 1.0; }
      open-on-output "DP-2"
  }

  // Zen Browser and Zed settings
  window-rule {
      match app-id=r#"^(zen-beta|dev\.zed\.Zed)$"#
      opacity 0.98
      default-column-width { proportion 0.75; }
  }

  // Web apps and Steam opacity
  window-rule {
      match app-id=r#"^(steam|chrome-app)$"#
      opacity 0.95
  }

  // Commented out: Steam fullscreen rule
  /-window-rule {
      match app-id="steam"
      exclude title="^Steam$"
      open-fullscreen true
  }
''
