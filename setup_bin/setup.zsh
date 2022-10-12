#!/bin/zsh

# Install oh-my-zsh
sh -c $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# oh-my-zsh plugins
for repo in (zsh-users/zsh-autosuggestions zsh-users/zsh-completions z-shell-F-Sy-H); do
  local plugin_name=${repo##*/}
  git clone git@github.com:${repo}.git ${ZSH_CUSTOM:=${ZSH:=$HOME/.oh-my-zsh}/custom}/plugins/$plugin_name
done
unset repo

# fzf zsh integration
local fzf_install=$(brew --prefix fzf)/install
[[ -f $fzf_install && ! -f ~/.fzf.zsh ]] && . $fzf_install
