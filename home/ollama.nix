{
  lib,
  pkgs,
  ...
}:
{
  systemd.user.services.ollama = {
    Unit.Description = "Ollama service (Tailscale-exposed)";
    Install.WantedBy = [ "default.target" ];

    Service = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "always";
      RestartSec = 5;
      TimeoutStopSec = 300;
      Environment = "OLLAMA_HOST=0.0.0.0:11434";
    };
  };

  home = {
    packages = [
      (pkgs.ollama.override {
        acceleration = "cuda"; # NOTE: rocm for AMD GPUs | cuda for NVIDIA GPUs
      })
    ];

    # auto-pull coding models on activation
    activation.pullOllamaModel = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.ollama}/bin/ollama pull qwen2.5-coder:7b
      ${pkgs.ollama}/bin/ollama pull llama3:8b
    '';
  };
}
