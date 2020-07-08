#!/bin/zsh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[[ -f "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc-backup"
ln -s "$DIR/.zshrc" "$HOME/.zshrc"
[[ -f "$HOME/.p10k.zsh" ]] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh-backup"
ln -s "$DIR/.p10k.zsh" "$HOME/.p10k.zsh"
[[ -f "$HOME/.zsh_scripts" ]] && mv "$HOME/.zsh_scripts" "$HOME/.zsh_scripts-backup"
ln -s "$DIR/.zsh_scripts" "$HOME/.zsh_scripts"
[[ -f "$HOME/.gitconfigs" ]] && mv "$HOME/.gitconfigs" "$HOME/.gitconfigs-backup"
ln -s "$DIR/.gitconfigs" "$HOME/.gitconfigs"
