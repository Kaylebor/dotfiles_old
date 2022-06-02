#!/bin/zsh

export ZSH=$HOME/.oh-my-zsh

typeset -U path cdpath fpath manpath

custom_zsh_functions=$HOME/.scripts/zsh/zsh-functions
path=(
  $HOME/.bin
  $path
  $HOME/.zsh/plugins/zsh-autosuggestions
  $HOME/.zsh/plugins/fast-syntax-highlighting
  $HOME/.zsh/plugins/zsh-completions
  $HOME/.zsh/plugins/zsh-autoenv
)
fpath=(
  $custom_zsh_functions
  $fpath
  $HOME/.zsh/plugins/zsh-autosuggestions
  $HOME/.zsh/plugins/fast-syntax-highlighting
  $HOME/.zsh/plugins/zsh-completions
  $HOME/.zsh/plugins/zsh-autoenv
  ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
)

# Load custom scripts
for func_name in $(ls $custom_zsh_functions)
  autoload -Uz $func_name
unset func_name
unset custom_zsh_functions

# Load Brew completions
if type brew &>/dev/null; then
  brew_site_functions=$(brew --prefix)/share/zsh/site-functions
  fpath=($brew_site_functions $fpath)
  for func_name in $(ls $brew_site_functions)
    autoload -Uz $func_name
  unset brew_site_functions
fi

# Environment variables
export BAT_THEME=Dracula
export DISABLE_AUTO_TITLE=true
export ERL_AFLAGS=-kernel shell_history enabled
export FZF_TMUX=1
export LANG=C.UTF-8
export LC_ALL=en_US.UTF-8
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export TIME_STYLE=long-iso
export XDG_CONFIG_HOME=$HOME/.config

# oh-my-zsh extra settings for plugins

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
      
# oh-my-zsh configuration
plugins=(
  F-Sy-H
  adb
  asdf
  command-not-found
  cp
  emacs
  extract
  fd
  fzf
  httpie
  mix-fast
  npm
  rake-fast
  rebar
  ripgrep
  urltools
  web-search
  zsh-autosuggestions
  zsh-interactive-cd
)
ZSH_THEME=dracula
source $ZSH/oh-my-zsh.sh

# History options
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
mkdir -p $(dirname $HISTFILE)

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Completion definitions for 1Password command line tool
if [[ -n $(command -v op) ]]; then
  eval $(op completion zsh)
  compdef _op op
fi

local source_files=(
  $HOME/.scripts/zsh/keybindings-fix.zsh
  $HOME/.local.zsh
)

for file in $source_files
  [[ -e $file ]] && source $file
unset file
unset source_files

# Define JAVA_HOME from asdf
if command -v asdf &> /dev/null; then
  export $(asdf env java | grep JAVA_HOME)
fi

# Configuring YubiKey
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

if [[ -o interactive && $TERM != "screen" && $TERM_PROGRAM = "iTerm.app" && -z $INSIDE_EMACS ]]; then
  source $HOME/.iterm2_shell_integration.zsh
fi

if [[ -n $(command -v tmuxp) ]]; then
  eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

# Opam package manager
eval $(opam env)

# fzf integration
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# Disable history expansion with '!''
setopt nobanghist

# Aliases
alias exa=exa -h -L2 --icons
alias g=git
alias ls=exa
alias lsg=exa --git-ignore
alias quit=exit
alias wine=wine64
alias sed=sed -E
alias python=python3
alias pip=pip3

# Making sure this path is first
path=(.git/safe/../../bin $path)

# Use tmux on certain environments (for multipane support mostly)
if command -v tmux &> /dev/null \
  && [[ -n $PS1 ]] \
  && [[ -z $TMUX ]] \
  && [[ ! $TERM =~ "screen|tmux" ]] \
  && [[ ! $TERM_PROGRAM =~ '(WarpTerminal|iTerm.app|vscode)' ]]
then
  exec tmux
fi
