{ config, pkgs, ... }:

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
      ".." = "cd ..";
      "..." = "./..";
      "...." = "././..";
      sv = "sudo vim";
      #-------------nix---------------------------------------------------->>>
      flake-rebuild = "sudo nixos-rebuild switch --flake ~/projects/megaos/#desktop";
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
      mostcli = "history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10";
      reload = "source ${config.home.homeDirectory}/.zshrc";
      #reload ="exec $SHELL -l";
      show_path = "echo $PATH | tr ':' '\n'";
      week = "date +%V";
      wttr = "curl wttr.in";
      #-------------git---------------------------------------------------->>>
      ga = "git add .";
      gb = "git branch -a";
      gbd = "git branch -d";
      gbod = "git push origin --delete";
      gc = "git commit -S -m ";
      gd = "git diff";
      gs = "git status";
      gdh = "git diff HEAD";
      gp = "git push";
      gpu = "git pull";
      gpt = "git push -u origin trunk";
      gph = "git push -u origin HEAD";
      gsl = "git stash list";
      gsf = "git stash push --";
      gsp = "git stash pop";
      gco = "git checkout";
      gcob = "git checkout -b";
      gcot = "git checkout trunk";
      gl = "git log";
      gla = "git log --all --graph --oneline";
      glo = "git log -1 --pretty=%H";

      pbcopy = "/mnt/c/Windows/System32/clip.exe";
      pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
      explorer = "/mnt/c/Windows/explorer.exe";
    };

    envExtra = ''
      #-------------starship------------------------------------------->>>
      LFILE="/etc/*-release"
      MFILE="/System/Library/CoreServices/SystemVersion.plist"
      if [[ -f $LFILE ]]; then
        _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
      elif [[ -f $MFILE ]]; then
        _distro="macos"

      #-------------determine-mac-model-------------------------------->>>
        _device=$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5,$6,$7}')

        case $_device in
          *MacBook*)     DEVICE="󰌢";;
          *)             DEVICE="";;
        esac
      fi

      # set an icon based on the distro
      # make sure your font is compatible with https://github.com/lukas-w/font-logos
      case $_distro in
          *kali*)                  ICON="󰠥";;
          *arch*)                  ICON="";;
          *debian*)                ICON="";;
          *raspbian*)              ICON="";;
          *ubuntu*)                ICON="";;
          *elementary*)            ICON="";;
          *fedora*)                ICON="";;
          *coreos*)                ICON="";;
          *gentoo*)                ICON="";;
          *mageia*)                ICON="";;
          *centos*)                ICON="";;
          *opensuse*|*tumbleweed*) ICON="";;
          *sabayon*)               ICON="";;
          *slackware*)             ICON="";;
          *linuxmint*)             ICON="";;
          *alpine*)                ICON="";;
          *aosc*)                  ICON="";;
          *nixos*)                 ICON="";;
          *devuan*)                ICON="";;
          *manjaro*)               ICON="";;
          *rhel*)                  ICON="";;
          *macos*)                 ICON="󰀵";;
          *)                       ICON="";;
      esac

      export STARSHIP_DISTRO="$ICON"
      export STARSHIP_DEVICE="$DEVICE"
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

    sessionVariables = { };
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

  # starship >>> config/starship.toml
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # fuck config
  programs.thefuck = {
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
