{ config, pkgs }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      format = """\
      [╭╴](046)$env_var\
      $all[╰─](046)$character"""
      character = {
        success_symbol = "[⟩](bold 046)";
        error_symbol = "[ƒ](bold 005)";
      };

      # Shows an icon depending on what distro it is running on
      env_var.STARSHIP_DISTRO = {
        format = '[$env_value](bold white) ';
        variable = "STARSHIP_DISTRO";
        disabled = false;
      };

      # Shows the current username
      env_var.USER = {
        format = '[$env_value](bold white) ';
        variable = "USER";
        disabled = false;
      };

      # Shows an icon depending on what device it is running on
      env_var.STARSHIP_DEVICE = {
        format = 'on [$env_value](bold yellow)';
        variable = "STARSHIP_DEVICE";
        disabled = false;
      };

      # Path settings
      username = {
        disabled = true;
      };
      hostname = {
        ssh_only = false;
        format = "[$hostname](bold yellow) ";
        disabled = false;
      };
      nix_shell = {
        symbol = "";
        format = "[$symbol$name]($style) ";
        style = "bright-purple bold";
      };
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        home_symbol = " ~";
        read_only_style = "197";
        read_only = "  ";
        format = "in [$path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        symbol = " ";
        format = "via [$symbol$branch]($style) ";
        truncation_symbol = "…/";
        style = "bold green";
      };
      git_status = {
        format = '[\($all_status$ahead_behind\)]($style) ';
        style = "bold green";
        conflicted = "󱚠 ";
        up_to_date = "󱓏 ";
        untracked = "󱙄 ";
        ahead = "󰶼${count}";
        diverged = "󱡷 󰶼${ahead_count}󰶹${behind_count}";
        behind = "⇣${count}";
        stashed = "󱧕 ";
        modified = "󱔽 ";
        staged = '[++\($count\)](green)';
        renamed = "󰽄 ";
        deleted = " ";
        submodule = " ";
      };
      golang = {
        format = 'via [💨 $version](bold cyan) ';
      };
      kubernetes = {
        format = 'via [󰠳 $context\($namespace\)](bold purple) ';
        disabled = false;
      };
      localip = {
        ssh_only = false;
        format = 'at [$localipv4](012) ';
        disabled = false;
      };
      ssh = {
        format = 'at [$ssh_symbol$hostname]($style) ';
        ssh_symbol = "󱕴󰣀 ";
        style = "bold blue";
        disabled = false;
        ssh-only = true;
      };

      # Disable some modules that are not needed anymore
      aws.disabled = true;
      docker_context.disabled = true;
      gcloud.disabled = true;
      helm.disabled = true;
      nodejs.disabled = true;
      python.disabled = true;
      ruby.disabled = true;
      terraform.disabled = true;
      vagrant.disabled = true;
    };
  };
}
