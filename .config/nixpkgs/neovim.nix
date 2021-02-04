{ pkgs, ... }: {
  
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

}
