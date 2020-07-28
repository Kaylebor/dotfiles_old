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

# Installing Rust packages
for package in exa hexyl; do
  [[ ! -f $(which $package) ]] && cargo install package # sharkdp/fd
done
[[ ! -f $(which bat) ]] && cargo install --locked bat # sharkdp/bat
[[ ! -f $(which fd) ]] && cargo install fd-find # sharkdp/fd
[[ ! -f $(which rg) ]] && cargo install --git https://github.com/BurntSushi/ripgrep ripgrep --features 'pcre2'
asdf reshim rust

# Installing Node packages
node-check-installed() { yarn global list --depth=0 | rg $1 }
for package in tldr; do
  [[ -z $(node-check-installed $package) ]] && yarn global add $package
done
asdf reshim nodejs

if [[ ! -f $HOME/.config/nvim/init.vim ]]; then
  mkdir -p $HOME/.config/nvim/
  ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
fi

cd $PREV_DIR
source $HOME/.zshrc
