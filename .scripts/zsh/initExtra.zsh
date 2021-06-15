#!/bin/zsh

source_files=(
  $HOME/.scripts/zsh/funcs.zsh
  $HOME/.scripts/zsh/keybindings-fix.zsh
  $HOME/.local.zsh
  $HOME/.nix-profile/etc/profile.d/nix.sh
  $HOME/.asdf/asdf.sh
  $HOME/.asdf/plugins/java/set-java-home.zsh
  $HOME/.iterm2_shell_integration.zsh
)

for file in $source_files; do
  [[ -e $file ]] && source $file
done

unset source_files

if [[ -n $(command -v op) ]]; then
  eval "$(op completion zsh)"
  compdef _op op
fi
