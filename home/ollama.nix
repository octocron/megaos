{
  lib,
  pkgs,
  ...
}:
let
  tailscaleListen = "100.114.98.44:11434"; # Or use "100.64.0.0" to listen on the whole Tailscale interface subnet
in
{
  systemd.user.services.ollama = {
    description = "Ollama user service (Tailscale-exposed)";
    wantedBy = [ "graphical-session.target" ]; # Starts after login / Hyprland session
    # Or use [ "default.target" ] if you want it even in non-graphical sessions

    serviceConfig = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "always";
      RestartSec = 5;
      Environment = "OLLAMA_HOST=${tailscaleListen}";
      # Optional extras:
      # Environment = ''OLLAMA_ORIGINS="*"'';  # If you need CORS for web UIs from other machines
      # LimitNOFILE = 65535;  # Helpful for many concurrent model loads
    };

    # Optional: ensure it only starts if Tailscale is up
    # You can add a more robust check via ExecStartPre if desired
  };

  home = {
    packages = [
      (pkgs.ollama.override {
        acceleration = "cuda"; # Change to "rocm" for AMD GPUs
      })
    ];

    # Optional: make the Ollama API endpoint easy to use in scripts/aliases
    sessionVariables = {
      OLLAMA_HOST = "http://${tailscaleListen}";
    };

    # Optional: auto-pull a good coding model on activation (uncomment if wanted)
    activation.pullOllamaModel = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.ollama}/bin/ollama pull qwen2.5-coder:32b-instruct-q5_K_M
    '';
  };
}
