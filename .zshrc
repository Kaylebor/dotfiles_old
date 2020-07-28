# Created by newuser for 5.8

# zsh history settings
export SAVEHIST=1000
export HISTFILE=~/.zsh_history

# Script with user-defined functions
source $HOME/.zsh_scripts/funcs.zsh

# ZSH completion styles
source $HOME/.zsh_scripts/zshcomp.zsh

# Initializes plugins (currently using zinit)
source $HOME/.zsh_scripts/plugin-setup.zsh

# Uses bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fixes keybindings; allows to use CTRL+Left/Right to skip words
source $HOME/.zsh_scripts/keybindings-fix.zsh

# Sets aliases
source $HOME/.zsh_scripts/aliases.zsh

# Starts background processes
source $HOME/.zsh_scripts/background.zsh

# Extra device-specific stuff
[[ -f $HOME/.zsh_local ]] && source $HOME/.zsh_local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initializes direnv
eval "$(direnv hook zsh)"
