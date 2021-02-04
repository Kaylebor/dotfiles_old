{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    hexyl
    fd
    ripgrep
    ripgrep-all
    bat
    zsh
    erlang
    elixir
    ruby
    python
    fzf
    direnv
    gitAndTools.hub
    gitAndTools.delta
  ];

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

  programs.git = {
    enable = true;
    delta ={
      enable = true;
    };
    extraConfig = {
      core = {
        editor = "code -w";
        eol = "lf";
        autocrlf = "input";
      };
    };
    userEmail = "veigabuenoender@gmail.com";
    userName = "Ender Veiga";
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      { plugin = ale;
        config = "
        let g:ale_completion_enabled=1
        let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
        "; }
      { plugin = vim-airline;
        config = "
          let g:airline#extensions#ale#enabled=1
        "; }
      { plugin = vim-airline-themes;
        config = "
          let g:airline_theme='luna'
        "; }
      { plugin = nerdtree;
        config = "
          \" NERDTree window width
          let g:NERDTreeWinSize=50
          \" NERDTree UI changes
          let NERDTreeMinimalUI=1
          let NERDTreeDirArrows=1
          \" open NERDTree with Ctrl+n
          map <C-n> :NERDTreeToggle<CR>
        "; }
      nerdtree-git-plugin
      dracula-vim
    ];
    extraConfig = "
      set number
      set hlsearch
      \" Makes new splits open on right and below
      set splitright splitbelow
      set tabstop=4 shiftwidth=4 expandtab
      \" Stop Neovim from autocommenting on Enter or Newline <o>
      set formatoptions-=cro
      autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
      \" For being able to edit using relative paths
      \" Makes the path where edit opens use the path of the current buffer
      set autochdir

      \" Change split with g+(vim direction key)
      nnoremap gh <C-W><C-H>
      nnoremap gj <C-W><C-J>
      nnoremap gk <C-W><C-K>
      nnoremap gl <C-W><C-L>
    ";
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
