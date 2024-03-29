#!/bin/zsh

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/title/XDG_Base_Directory#Support
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_STATE_HOME=$HOME/.local/state

export ZSH=${ZSH:-$HOME/.oh-my-zsh}
export ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}

# Set asdf variables
export ASDF_DIR=$HOME/.asdf
export ASDF_DATA_DIR=$HOME/.asdf_data

typeset -U path cdpath fpath manpath

custom_zsh_functions=$HOME/.scripts/zsh/zsh-functions
path=(
  .git/safe/../../bin
  $HOME/.scripts/bin
  $ASDF_DATA_DIR/shims
  $ASDF_DIR/bin
  $HOME/.local/bin
  /usr/local/opt/wget/bin
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/gnu-indent/libexec/gnubin
  /usr/local/opt/gnu-getopt/bin
  /usr/local/opt/curl/bin
  /usr/local/opt/coreutils/libexec/gnubin
  $HOME/bin
  $HOME/go/bin
  $path
  $ZSH_CUSTOM/plugins/zsh-autosuggestions
  $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  $ZSH_CUSTOM/plugins/zsh-completions
  $HOME/.emacs.d/bin
)
fpath=(
  $custom_zsh_functions
  $fpath
  $ZSH_CUSTOM/plugins/zsh-autosuggestions
  $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  $ZSH_CUSTOM/plugins/zsh-completions
  $ZSH_CUSTOM/plugins/zsh-completions/src
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
export KERL_BUILD_DOCS=yes
export FZF_TMUX=1
export LANG=C.UTF-8
export LC_ALL=en_US.UTF-8
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export TIME_STYLE=long-iso

export EDITOR="emacs -nw"
export ALTERNATE_EDITOR="nvim"

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
  direnv
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
  $ASDF_DIR/asdf.sh
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

if [[ -n $(command -v tmuxp) ]]; then
  eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

# Opam package manager
eval $(opam env)

# fzf integration
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# Starship prompt
eval "$(starship init zsh)"

# Disable history expansion with '!''
setopt nobanghist

# Aliases
alias exa=exa -h -L2 --icons
alias g=git
alias ls=exa
alias lsg=exa --git-ignore
alias quit=exit
[[ -n $(command -v wine64) ]] && alias wine=wine64
alias sed=sed -E
alias cat='bat --paging=never'
