{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    shellAliases = {
      g = "git";
      exa = "exa -h -L2 --icons";
      ls = "exa";
      lsg = "exa --git-ignore";
    };

    sessionVariables = {
      LC_ALL="en_US.UTF-8";
      LANG="C.UTF-8";
      MANPAGER="sh -c 'col -bx | bat -l man -p'";
      RIPGREP_CONFIG_PATH="$HOME/.ripgreprc";
      BAT_THEME="Dracula";
      FZF_TMUX="1";
      ERL_AFLAGS="-kernel shell_history enabled";
      DISABLE_AUTO_TITLE="true";
      TIME_STYLE="long-iso";
      EDITOR="emacsclient -nw";
      VISUAL="emacsclient -nw";
      XDG_CONFIG_HOME="$HOME/.config";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "asdf"
        "adb"
        "extract"
        "command-not-found"
        "cp"
        "fd"
        "fzf"
        "httpie"
        "ripgrep"
        "mix-fast"
        "rake-fast"
        "npm"
        "rebar"
        "urltools"
        "web-search"
        "zsh-interactive-cd"
      ];
      extraConfig = "
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes
      ";
      theme = "dracula";
      custom = "$HOME/.oh-my-zsh";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.33.0";
          sha256 = "0vs14n29wvkai84fvz3dz2kqznwsq2i5fzbwpv8nsfk1126ql13i";
        };
      }
      {
        name = "zsh-autoenv";
        file = "autoenv.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Tarrasch";
          repo = "zsh-autoenv";
          rev = "e9809c1bd28496e025ca05576f574e08e93e12e8";
          sha256 = "1vcfk9g26zqn6l7pxjqidw8ay3yijx95ij0d7mns8ypxvaax242b";
        };
      }
    ];

    initExtra = "source $HOME/.scripts/zsh/initExtra.zsh";
  };
}
