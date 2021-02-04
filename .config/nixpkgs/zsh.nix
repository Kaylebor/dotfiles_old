{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "extract"
        "cp"
        "fd"
        "fzf"
        "ripgrep"
        "ssh-agent"
      ];
      extraConfig =
      "
      zstyle :omz:plugins:ssh-agent identities id_ed25519
      ";
      theme = "agnoster";
    };
    plugins = [
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
    shellAliases = {
      ls = "exa";
    };
    envExtra =
    "
      export LANG=C.UTF-8
      export MANPAGER=\"sh -c 'col -bx | bat -l man -p'\"
      export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
    ";
    initExtraBeforeCompInit =
    "
      source $HOME/.scripts/zsh/keybindings-fix.zsh
      source $HOME/.scripts/zsh/funcs.zsh
    ";
    initExtra = "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi";
  };
}
