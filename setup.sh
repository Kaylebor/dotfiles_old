#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[[ -f "$HOME/.zshrc" ]] && mv $HOME/.zshrc $HOME/.zshrc-backup
ln -s $DIR/.zshrc $HOME/.zshrc
ln -s $DIR/.p10k.zsh $HOME/.p10k.zsh
ln -s $DIR/.zsh_scripts $HOME/.zsh_scripts
