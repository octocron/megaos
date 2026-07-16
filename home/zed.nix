_: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "codebook"
      "dockerfile"
      "docker-compose"
      "html"
      "ini"
      "marksman"
      "toml"
      "scss"
      "yaml"
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      helix_mode = false;
      ui_font_size = 18;
      buffer_font_size = 18;
      lsp = {
        gopls.binary.path = "gopls";
        rust-analyzer.binary.path = "rust-analyzer";
        pylsp.binary.path = "pylsp";
      };
      diagnostics.inline = {
        enabled = true;
        max_severity = null;
      };
    };
  };
}
