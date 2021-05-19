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
        "asdf"
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
      theme = "dracula";
      custom = "$HOME/.oh-my-zsh";
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
      git = "hub";
    };
    sessionVariables = {
      LC_ALL="en_US.UTF-8";
      LANG="C.UTF-8";
      MANPAGER="sh -c 'col -bx | bat -l man -p'";
      RIPGREP_CONFIG_PATH="$HOME/.ripgreprc";
    };
    initExtraBeforeCompInit = "
      path+=/usr/local/sbin
      function source_from_array {
        for file in $1; [[ -e $file ]] && source $file
      }
      function sort_uniq {
        if [[ -z $@ ]]; then
          local to_sort=$(</dev/stdin)
          printf \"%s\n\" $\{to_sort[@]} | awk '{$1=$1};1' | sort -u
        else
          printf \"%s\n\" $@ | awk '{$1=$1};1' | sort -u
        fi
      }
      source_files=(
        $HOME/.localenv
        $HOME/.scripts/zsh/funcs.zsh
        $HOME/.scripts/zsh/keybindings-fix.zsh
      )
      source_from_array $source_files
      unset source_files
    ";
    initExtra = "
      extra_source_files=(
        $HOME/.nix-profile/etc/profile.d/nix.sh
        $HOME/.asdf/asdf.sh
        $HOME/.asdf/plugins/java/set-java-home.zsh
        $HOME/.iterm2_shell_integration.zsh
      )
      source_from_array $extra_source_files
      unset extra_source_files
      ";
  };
}
