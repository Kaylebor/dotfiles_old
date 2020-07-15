#!/bin/zsh

check-running-containers() {
    echo $(docker container ps -f 'status=running' -f "ancestor=$1" | tail -n +2 | wc -l)
}

check-previous-container-name() {
    echo $(docker container ps -a -f "ancestor=$1" | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
}

PREV_DIR=$(pwd)
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)/docker

[[ $ENABLE_JDT -eq 1 ]] && docker-compose up -d jdt
[[ $ENABLE_JELLYFIN -eq 1 ]] && docker-compose up -d jellyfin
[[ $ENABLE_JUPYTER_SCIPY -eq 1 ]] && docker-compose up -d jupyter-scipy

cd $PREV_DIR