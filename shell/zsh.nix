{ config, pkgs, username, gitUsername, gitEmail, ... }:

{
  # Configure zsh
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history.save = 10000;
    history.size = 10000;
    history.ignoreDups = true;
    history.ignoreSpace = true;
    history.expireDuplicatesFirst = true;
    historySubstringSearch.enable = true;

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    shellAliases = {
      ".."="cd ..";
      "..." = "./..";
      "...." = "././..";
      sv="sudo vim";
      #-------------nix---------------------------------------------------->>>
      flake-rebuild="sudo nixos-rebuild switch --flake ~/projects/megaos/#desktop";
      ncg = "nix-collect-garbage --delete-old";
      #-------------aliases------------------------------------------------>>>
      a = "ansible";
      ap = "ansible-playbook";
      d3 = "cd ~/projects/hugo/d3c3p7/";
      ftldr = "tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70% | xargs tldr";
      grep = "grep --color";
      kg = "killall gpg-agent || true; gpg-agent --daemon";
      la = "eza --group-directories-first -la";
      ls = "eza --icons --group-directories-first";
      lt = "eza -lhTL";
      lsd = "eza -D";
      lg = "eza -lh --git";
      mostcli = "history | awk '{print $2} | sort | uniq -c | sort -nr | head -10";
      reload = "source ${config.home.homeDirectory}/.zshrc";
      #reload ="exec $SHELL -l";
      show_path = "echo $PATH | tr ':' '\n'";
      vimcon = "vim ~/.vimrc";
      week = "date +%V";
      wttr = "curl wttr.in";
      #-------------git---------------------------------------------------->>>
      ga = "git add .";
      gc = "git commit -S -m ";
      gd = "git diff";
      gs = "git status";
      gdh = "git diff HEAD";
      gp = "git push";
      gpt = "git push -u origin trunk";
      gph = "git push -u origin HEAD";
      gco = "git checkout";
      gcob = "git checkout -b";
      gct = "git checkout trunk";

      pbcopy = "/mnt/c/Windows/System32/clip.exe";
      pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
      explorer = "/mnt/c/Windows/explorer.exe";
    };

    envExtra = ''
      export PATH=$PATH:$HOME/.local/bin
    '';

    initExtra = ''
      # fixes duplication of commands when using tab-completion
      export LANG=C.UTF-8
    '';
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';

    sessionVariables = {
    
    };
  };

#-------------zsh plugins---------------------------------------------------->>>
  # broot config
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  # direnv config
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # fzf config
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # zoxide config
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
 
}
