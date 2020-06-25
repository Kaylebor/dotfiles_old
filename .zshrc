# Created by newuser for 5.8

# ZSH completion styles
. "$HOME/.zsh_scripts/zshcomp.zsh"

# Initializes plugins (currently using zinit)
. "$HOME/.zsh_scripts/plugin-setup.zsh"

# Uses most for man pages
export PAGER="most"

# Fixes keybindings; allows to use CTRL+Left/Right to skip words
. "$HOME/.zsh_scripts/keybindings-fix.zsh"

# Script with user-defined functions
. "$HOME/.zsh_scripts/funcs.zsh"

# Sets aliases
. "$HOME/.zsh_scripts/aliases.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
