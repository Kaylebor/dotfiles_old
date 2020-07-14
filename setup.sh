#!/bin/zsh
PREV_DIR=$(pwd)
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)
DIR="$(pwd)"

[[ ! -d "$HOME/.backups" ]] && mkdir -p "$HOME/.backups"

for file in .zshrc .p10k.zsh .zsh_scripts .gitconfigs .tool-versions; do
    [[ -e "$HOME/$file" ]] && mv "$HOME/$file" "$HOME/.backups/"
    ln -s "$DIR/$file" "$HOME/"
done

cd $HOME
asdf install
cd $PREV_DIR
# source $HOME/.zshrc