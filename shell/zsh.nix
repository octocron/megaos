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
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^e' end-of-line
      bindkey '^w' forward-word
      bindkey "^[[3~" delete-char
      bindkey ";5C" forward-word
      bindkey ";5D" backward-word

      zstyle ':completion:*:*:*:*:*' menu select

      # Complete . and .. special directories
      zstyle ':completion:*' special-dirs true

      zstyle ':completion:*' list-colors ""
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

      # disable named-directories autocompletion
      zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

      # Use caching so that commands like apt and dpkg complete are useable
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Don't complete uninteresting users
      zstyle ':completion:*:*:*:users' ignored-patterns \
              adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
              clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
              gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
              ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
              named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
              operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
              rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
              usbmux uucp vcsa wwwrun xfs '_*'
      # ...unless we really want to.
      zstyle'*' single-ignored complete

      # https://thevaluable.dev/zsh-completion-guide-ezamples/
      zstyle ':completion:*' completer _extensions _complete _approximate
      zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
      zstyle ':completion:*' squeeze-slashes true
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # mkcd is equivalent to takedir
      function mkcd takedir() {
        mkdir -p $@ && cd ''${@:$#}
      }

      function takeurl() {
        local data thedir
        data="$(mktemp)"
        curl -L "$1" > "$data"
        tar xf "$data"
        thedir="$(tar tf "$data" | head -n 1)"
        rm "$data"
        cd "$thedir"
      }

      function takegit() {
        git clone "$1"
        cd "$(basename ''${1%%.git})"
      }

      function take() {
        if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
          takeurl "$1"
        elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
          takegit "$1"
        else
          takedir "$@"
        fi
      }

      WORDCHARS='*?[]~=&;!#$%^(){}<>'

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

  # nix-index config
  programs.nix-index = {
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
