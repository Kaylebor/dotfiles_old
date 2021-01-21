# Created by newuser for 5.8

# zsh history settings
export SAVEHIST=1000
export HISTFILE=~/.zsh_history
export PATH=$HOME/.local/bin:$PATH

[[ -d ~/.zsh/functions ]] && export fpath=(~/.zsh/functions $fpath)

# ripgrep configuration file
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Script with user-defined functions
source $HOME/.scripts/zsh/funcs.zsh

# ZSH completion styles
source $HOME/.scripts/zsh/zshcomp.zsh

# Initializes plugins (currently using zinit)
source $HOME/.scripts/zsh/plugin-setup.zsh

# Uses bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fixes keybindings; allows to use CTRL+Left/Right to skip words
source $HOME/.scripts/zsh/keybindings-fix.zsh

# Sets aliases
source $HOME/.scripts/zsh/aliases.zsh

# Starts background processes
source $HOME/.scripts/zsh/background.zsh

# Extra device-specific stuff
[[ -f $HOME/.zsh_local ]] && source $HOME/.zsh_local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initializes direnv
eval "$(direnv hook zsh)"
