#!/bin/zsh
PREV_DIR=$(pwd)
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)
DIR="$(pwd)"

for arg in "$@"; do
  case $arg in
    -h|--help)
    echo "TODO: help"
    exit 0
    ;;
    -r|--reinstall-packages)
    REINSTALL_PACKAGES=1
    ;;
  esac
done

[[ ! -d "$HOME/.backups" ]] && mkdir -p "$HOME/.backups"

for file in .zshrc .p10k.zsh .zsh_scripts .gitconfigs .tool-versions; do
  [[ -e "$HOME/$file" ]] && mv "$HOME/$file" "$HOME/.backups/"
  ln -s "$DIR/$file" "$HOME/"
done

cd $HOME
asdf install

# Installing Rust packages
for package in exa hexyl fd-find; do
  [[ $REINSTALL_PACKAGES -eq 1 || ! -f $(which $package) ]] && cargo install --force $package # sharkdp/fd
done
[[ $REINSTALL_PACKAGES -eq 1 || ! -f $(which bat) ]] && cargo install --force --locked bat # sharkdp/bat
[[ $REINSTALL_PACKAGES -eq 1 || ! -f $(which rg) ]] && cargo install --force --git https://github.com/BurntSushi/ripgrep ripgrep --features 'pcre2'
asdf reshim rust

# Installing Node packages
node-check-installed() { yarn global list --depth=0 | rg $1 }
for package in tldr; do
  [[ $REINSTALL_PACKAGES -eq 1 || -z $(node-check-installed $package) ]] && yarn global add $package
done
asdf reshim nodejs

if [[ ! -f $HOME/.config/nvim/init.vim ]]; then
  mkdir -p $HOME/.config/nvim/
  ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
fi

cd $PREV_DIR
source $HOME/.zshrc
