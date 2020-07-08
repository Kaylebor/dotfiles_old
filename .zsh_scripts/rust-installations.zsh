#!/bin/zsh

[[ ! -f $(which bat) ]] && cargo install --locked bat # sharkdp/bat

[[ ! -f $(which fd) ]] && cargo install fd-find # sharkdp/fd

[[ ! -f $(which exa) ]] && cargo install exa # ogham/exa

[[ ! -f $(which hexyl) ]] && cargo install hexyl # sharkdp/hexyl

[[ ! -f $(which rg) ]] && cargo install --git https://github.com/BurntSushi/ripgrep ripgrep --features 'pcre2'

asdf reshim rust
