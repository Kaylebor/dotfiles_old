#!/bin/zsh

which rg > /dev/null
[[ $? != 0 ]] && cargo install ripgrep

which bat > /dev/null # sharkdp/bat
[[ $? != 0 ]] && cargo install --locked bat

which fd > /dev/null # sharkdp/fd
[[ $? != 0 ]] && cargo install fd-find

which exa > /dev/null # ogham/exa
[[ $? != 0 ]] && cargo install exa

which hexyl > /dev/null # sharkdp/hexyl
[[ $? != 0 ]] && cargo install hexyl

asdf reshim rust
