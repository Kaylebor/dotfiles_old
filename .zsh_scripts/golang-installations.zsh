#!/bin/zsh

[[ ! -d ~/.direnv ]] && git clone https://github.com/direnv/direnv.git ~/.direnv
current_tag=$(git -C ~/.direnv describe --tags)
latest_release=$(get_latest_release direnv/direnv)
if [[ $current_tag != $latest_release ]]; then
    prev_dir=$(pwd)
    cd ~/.direnv
    git fetch > /dev/null
    git checkout $latest_release 2> /dev/null
    git merge FETCH_HEAD > /dev/null
    make
    ~/.direnv/direnv hook zsh > hook.zsh
    cd $prev_dir
fi
. ~/.direnv/hook.zsh 2>&1 > /dev/null