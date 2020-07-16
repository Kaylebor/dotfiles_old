#!/bin/zsh

check-running-containers() {
    echo $(docker container ps -f 'status=running' -f "ancestor=$1" | tail -n +2 | wc -l)
}

check-previous-container-name() {
    echo $(docker container ps -a -f "ancestor=$1" | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
}

PREV_DIR=$(pwd)
cd $(dirname -- "$0")/docker

[[ $ENABLE_JDT -eq 1 ]] && docker-compose --log-level ERROR up -d jdt
[[ $ENABLE_JELLYFIN -eq 1 ]] && docker-compose --log-level ERROR up -d jellyfin
[[ $ENABLE_JUPYTER_SCIPY -eq 1 ]] && docker-compose --log-level ERROR up -d jupyter-scipy

cd $PREV_DIR