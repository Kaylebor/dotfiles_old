#!/bin/zsh

node-check-installed() { yarn global list --depth=0 | rg $1 }

for package in tldr; do
    [[ -z $(node-check-installed $package) ]] && yarn global add $package
done