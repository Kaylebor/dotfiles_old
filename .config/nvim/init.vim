call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-editors/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'khaveesh/vim-fish-syntax'

call plug#end()

let g:airline#extensions#ale#enabled=1
let g:airline_theme='luna'

" NERDTree window width
let g:NERDTreeWinSize=50
" NERDTree UI changes
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

set number
set hlsearch
" Makes new splits open on right and below
set splitright splitbelow
set tabstop=4 shiftwidth=4 expandtab
" Stop Neovim from autocommenting on Enter or Newline <o>
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" For being able to edit using relative paths
" Makes the path where edit opens use the path of the current buffer
set autochdir
" Set neovim to use fzf
set rtp+=/usr/local/opt/fzf

" Change split with g+(vim direction key)
nnoremap gh <C-W><C-H>
nnoremap gj <C-W><C-J>
nnoremap gk <C-W><C-K>
nnoremap gl <C-W><C-L>
