# Created by newuser for 5.8

# zsh history settings
export SAVEHIST=1000
export HISTFILE=~/.zsh_history

# Script with user-defined functions
. $HOME/.zsh_scripts/funcs.zsh

# ZSH completion styles
. $HOME/.zsh_scripts/zshcomp.zsh

# Initializes plugins (currently using zinit)
. $HOME/.zsh_scripts/plugin-setup.zsh

# Installs some things via asdf
. $HOME/.zsh_scripts/asdf-installations.zsh

# Installs Rust packages
. $HOME/.zsh_scripts/rust-installations.zsh

# Installs Go utilities
. $HOME/.zsh_scripts/golang-installations.zsh

# Uses bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fixes keybindings; allows to use CTRL+Left/Right to skip words
. $HOME/.zsh_scripts/keybindings-fix.zsh

# Sets aliases
. $HOME/.zsh_scripts/aliases.zsh

# Starts background processes
. $HOME/.zsh_scripts/background.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
