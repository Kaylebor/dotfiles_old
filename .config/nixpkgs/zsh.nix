{ pkgs, ... }: {
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;

  programs.zsh.history.expireDuplicatesFirst = true;
  programs.zsh.history.extended = true;
  programs.zsh.history.ignoreDups = true;
  programs.zsh.history.save = 10000;
  programs.zsh.history.size = 10000;

  programs.zsh.shellAliases.ls = "exa";
  programs.zsh.shellAliases.lst = "exa -TL2";
  programs.zsh.shellAliases.lsg = "exa --git-ignore";
  programs.zsh.shellAliases.lstg = "exa -TL2 --git-ignore";

  programs.zsh.sessionVariables.LC_ALL="en_US.UTF-8";
  programs.zsh.sessionVariables.LANG="C.UTF-8";
  programs.zsh.sessionVariables.MANPAGER="sh -c 'col -bx | bat -l man -p'";
  programs.zsh.sessionVariables.RIPGREP_CONFIG_PATH="$HOME/.ripgreprc";
  programs.zsh.sessionVariables.BAT_THEME="Dracula";
  programs.zsh.sessionVariables.FZF_TMUX="1";

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "asdf"
    "adb"
    "extract"
    "command-not-found"
    "cp"
    "fd"
    "fzf"
    "httpie"
    "ripgrep"
    "ssh-agent"
    "mix-fast"
    "rake-fast"
    "npm"
    "rebar"
    "timer"
    "urltools"
    "web-search"
    "zsh-interactive-cd"
  ];
  programs.zsh.oh-my-zsh.extraConfig = "
  zstyle :omz:plugins:ssh-agent identities id_ed25519
  zstyle ':completion:*:*:docker:*' option-stacking yes
  zstyle ':completion:*:*:docker-*:*' option-stacking yes";
  programs.zsh.oh-my-zsh.theme = "dracula";
  programs.zsh.oh-my-zsh.custom = "$HOME/.oh-my-zsh";

  programs.zsh.plugins = [
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
          owner = "zdharma";
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

  programs.zsh.initExtraBeforeCompInit = "path+=/usr/local/sbin";

  programs.zsh.initExtra = "source $HOME/.scripts/zsh/initExtra.zsh";
}
