{ pkgs, ... }: {
  services.ollama = {
    enable = true;
    # NOTE: rocm for AMD GPUs | cuda for NVIDIA GPUs
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
    port = 11434;
    loadModels = [
      "qwen3:8b-q4_K_M"
    ];
    openFirewall = false;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "10m";
      OLLAMA_MAX_LOADED_MODELS = "1";
    };
  };
}
