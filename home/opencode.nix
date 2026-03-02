_: {
  programs.opencode = {
    enable = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {
            "llama4:scout" = {
              name = "Llama 4 Scout";
            };
            "qwen3-coder:30b" = {
              name = "Qwen 3 Coder";
            };
          };
        };
      };
      model = "qwen3-coder:30b";
      agent = {
        nix-flake-expert = {
          description = "Expert assistant for Nix flakes, NixOS, and Home Manager configurations";
          mode = "all";
          model = "qwen3-coder:30b";
          prompt = ''
            You are a world-class Nix expert with deep knowledge of Nix flakes, NixOS modules, Home Manager, and declarative configurations.
            Always respond with declarative Nix expressions.
            Focus on modularity, reproducibility, and best practices.
            Avoid imperative suggestions or manual commands.
            Structure responses with clear modules, options, and explanations in comments.
          '';
          tools = {
            bash = true;
            edit = true;
            write = true;
          };
          permission = {
            bash = {
              "*" = "ask";
              "nix *" = "allow";
              "nixos-rebuild *" = "ask";
            };
          };
          temperature = 0.2;
          steps = 10;
        };
        nix-debugger = {
          description = "Debugger for Nix configurations and flakes";
          mode = "subagent";
          model = "llama4:scout";
          prompt = ''
            You are a Nix debugging specialist.
            Analyze provided Nix code or error messages.
            Identify syntax errors, deprecated options, type mismatches, or flake structure issues.
            Provide corrected declarative Nix configurations.
            Include explanations in Nix comments.
          '';
          tools = {
            bash = true;
            read = true;
          };
          permission = {
            bash = {
              "nix eval *" = "allow";
              "nix flake check *" = "allow";
            };
          };
          temperature = 0.1;
        };
        nix-optimizer = {
          description = "Optimizer for Nix flakes and configurations";
          mode = "subagent";
          model = "qwen3-coder:30b";
          prompt = ''
            You are an expert in optimizing Nix configurations.
            Suggest improvements for performance, modularity, and efficiency.
            Focus on declarative patterns, input management, and resource usage.
            Rewrite provided code in optimized declarative form.
          '';
          tools = {
            edit = true;
            bash = true;
          };
          permission = {
            bash = {
              "nix store optimise *" = "allow";
            };
          };
          temperature = 0.3;
        };
      };
      command = {
        refactor = {
          description = "Refactor selected code for better readability";
          template = "Refactor this code to improve readability and maintainability while preserving functionality";
        };
        document = {
          description = "Add documentation to code";
          template = "Add comprehensive documentation comments to this code";
        };
        test = {
          description = "Generate unit tests";
          template = "Generate comprehensive unit tests for this function";
        };
        explain = {
          description = "Explain code functionality";
          template = "Explain what this code does in simple terms";
        };
      };
    };
  };
}
