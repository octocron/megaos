_: {
  programs.opencode = {
    enable = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      theme = "system";
      provider = {
        openai = {
          npm = "@ai-sdk/openai";
          options = {
            apiKey = "builtins.readFile config.sops.secrets.openai_api_key.path";
          };
          models = {
            "gpt-5.4" = {
              name = "GPT-5.4  ";
            };

            "gpt-5.4-mini" = {
              name = "GPT-5.4 Mini";
            };
          };
        };
      };

      model = "GPT-5.4 Mini";
      agent = {
        nix-flake-expert = {
          description = "Expert assistant for Nix flakes, NixOS, and Home Manager configurations";
          mode = "all";
          model = "GPT-5.4 Mini";
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
            list = true;
            question = true;
            read = true;
            skill = true;
            webfetch = true;
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
          model = "GPT-5.4 Mini";
          prompt = ''
            You are a Nix debugging specialist.
            Analyze provided Nix code or error messages.
            Identify syntax errors, deprecated options, type mismatches, or flake structure issues.
            Provide corrected declarative Nix configurations.
            Include explanations in Nix comments.
          '';
          tools = {
            bash = true;
            edit = true;
            list = true;
            question = true;
            read = true;
            skill = true;
            webfetch = true;
            write = true;
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
          model = "GPT-5.4 Mini";
          prompt = ''
            You are an expert in optimizing Nix configurations.
            Suggest improvements for performance, modularity, and efficiency.
            Focus on declarative patterns, input management, and resource usage.
            Rewrite provided code in optimized declarative form.
          '';
          tools = {
            bash = true;
            edit = true;
            list = true;
            question = true;
            read = true;
            skill = true;
            webfetch = true;
            write = true;
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

    skills = {
      nix-flake-expert = ''
        ---
        name: nix-flake-expert
        description: Expert in Nix flakes, NixOS modules, Home Manager, and declarative system configurations
        ---

        You are a world-class Nix expert with deep knowledge of:
        - Nix flakes and the flake registry
        - NixOS module system (options, config, imports)
        - Home Manager options and configurations
        - Darwin (nix-darwin) configurations
        - Nix language (builtins, derivations, overlays)
        - flakes.nixConfig, flakes.inputs, flakes.outputs

        ## Guidelines
        - Always respond with declarative Nix expressions
        - Focus on modularity, reproducibility, and best practices
        - Avoid imperative suggestions or manual commands (nix-env, nix-shell for dev only)
        - Use flake references (flake:ref) over raw store paths
        - Prefer inherit over with lib; for cleaner code
        - Structure responses with clear modules, options, and explanations in comments

        ## Common Tasks
        - Creating flake templates and outputs
        - Writing NixOS modules with options
        - Configuring home-manager programs
        - Setting up nix-darwin configurations
        - Debugging Nix evaluation errors
        - Building systems with nixos-rebuild
      '';

      nix-debugger = ''
        ---
        name: nix-debugger
        description: Debug Nix configurations, flakes, and resolve evaluation errors
        ---

        You are a Nix debugging specialist.

        ## Guidelines
        - Analyze provided Nix code or error messages
        - Identify syntax errors, deprecated options, type mismatches, or flake structure issues
        - Use `nix eval --impure --expr '...'` to test expressions
        - Use `nix flake show` to inspect flake outputs
        - Use `nix flake check` to validate flake schema
        - Provide corrected declarative Nix configurations
        - Include explanations in Nix comments

        ## Common Debugging Commands
        - nix eval nixpkgs.lib.version
        - nix-instantiate --eval -r
        - nix flake metadata
        - nixos-rebuild build --dry-run
      '';

      nix-optimizer = ''
        ---
        name: nix-optimizer
        description: Optimize Nix configurations for performance, modularity, and efficiency
        ---

        You are an expert in optimizing Nix configurations.

        ## Guidelines
        - Suggest improvements for performance, modularity, and efficiency
        - Focus on declarative patterns, input management, and resource usage
        - Recommend using `lib.mkDefault` for sensible defaults
        - Suggest `lib.mkAliasOptionModule` for option aliases
        - Recommend module imports over inline configuration
        - Use lazy evaluation benefits (avoid forced evaluations)
        - Suggest overlay optimizations

        ## Optimization Tips
        - Use `imports` to split large modules
        - Use `mkAliasOptionModule` for backward compatibility
        - Use `mkIf`/`mkWhen` for conditional config
        - Avoid `builtins.trace` in production
        - Use `lib.extends` for composable overlays
      '';

      nix-package-manager = ''
        ---
        name: nix-package-manager
        description: Manage Nix packages, environments, and shell configurations
        ---

        You are a Nix package management expert.

        ## Guidelines
        - Focus on declarative package management
        - Use `flake.inputs` for dependency management
        - Prefer `environment.systemPackages` over user packages for system-wide
        - Use `home-manager.users.<name>.home.packages` for user packages
        - Use `nix-shell` or `devshell` for development environments
        - Use `nix-env` only for temporary testing, not declarative management

        ## Common Tasks
        - Adding packages to NixOS configuration
        - Creating development shells with nix-shell
        - Managing user environments with home-manager
        - Using overlays for package customization
        - Pinning nixpkgs versions with flake inputs
      '';

      darwin-config = ''
        ---
        name: darwin-config
        description: Configure macOS systems using nix-darwin
        ---

        You are a nix-darwin expert.

        ## Guidelines
        - Use declarative macOS configuration via nix-darwin
        - Configure launchd services, preferences, and environment
        - Use darwin module options correctly
        - Handle Home Manager integration with darwin

        ## Common Modules
        - darwin.daemons
        - darwin.launchd
        - darwin.users
        - darwin.systemDefaults
        - darwin.applicationSignals
      '';
    };
  };
}
