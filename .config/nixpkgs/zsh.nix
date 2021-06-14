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

  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "asdf"
    "extract"
    "cp"
    "fd"
    "fzf"
    "ripgrep"
    "ssh-agent"
  ];
  programs.zsh.oh-my-zsh.extraConfig = "zstyle :omz:plugins:ssh-agent identities id_ed25519";
  programs.zsh.oh-my-zsh.theme = "dracula";
  programs.zsh.oh-my-zsh.custom = "$HOME/.oh-my-zsh";

  programs.zsh.plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.4";
          sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
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
          rev = "0.31.0";
          sha256 = "0rw23m8cqxhcb4yjhbzb9lir60zn1xjy7hn3zv1fzz700f0i6fyk";
        };
      }
    ];

  programs.zsh.initExtraBeforeCompInit = "path+=/usr/local/sbin";

  programs.zsh.initExtra = "source $HOME/.scripts/zsh/initExtra.zsh";
}
