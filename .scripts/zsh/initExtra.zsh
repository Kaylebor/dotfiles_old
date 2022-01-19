#!/bin/zsh

fpath=("$HOME/.scripts/zsh/zsh-functions" "${fpath[@]}")
for func_name in $(ls "$HOME/.scripts/zsh/zsh-functions")
  autoload -Uz $func_name
unset func_name

local source_files=(
  $HOME/.scripts/zsh/keybindings-fix.zsh
  $HOME/.nix-profile/etc/profile.d/nix.sh
  $HOME/.asdf/asdf.sh
  $HOME/.iterm2_shell_integration.zsh
  $HOME/.local.zsh
)

export $(asdf env java | grep JAVA_HOME)

for file in $source_files
  [[ -e $file ]] && source $file

if [[ -o interactive && $TERM != "screen" && -a $ITERM_SHELL_INTEGRATION_INSTALLED && -z $INSIDE_EMACS ]]; then
  source $HOME/.iterm2_shell_integration.zsh
fi

if [[ -n $(command -v tmuxp) ]]; then
  eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

if [[ -n $(command -v op) ]]; then
  eval "$(op completion zsh)"
  compdef _op op
fi

# Disable history expansion with '!''
setopt nobanghist

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi
