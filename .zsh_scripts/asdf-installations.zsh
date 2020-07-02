#!/bin/zsh

which asdf > /dev/null
if [[ $? == 0 ]]; then
    for plugin in rust golang
    do
        asdf_install_latest $plugin
    done
fi