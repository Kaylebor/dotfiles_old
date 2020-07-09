#!/bin/zsh

check_not_running() {
    unset not_running
    if [[ -f $(which docker) && \
        ! -z $(docker image ls | rg $1) && \
        -z $(docker container ps -f 'status=running' -f 'ancestor=$1' | rg --invert-match IMAGE | tr -s ' ' | cut -d ' ' -f 2) ]]; then
        not_running=1
        prev_container=$(docker container ps -a -f "ancestor=$1" | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
    fi
}

if [[ ! -z ENABLE_JDT ]]; then
    jdt_container="kaylebor/eclipse.jdt.ls"
    check_not_running $jdt_container
    if [[ ! -z not_running  ]]; then
        if [[ -z $prev_container ]]; then
            docker run -d --net=host $jdt_container 2>&1 > /dev/null
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi

if [[ ! -z ENABLE_JELLYFIN ]]; then
    jellyfin_container="jellyfin/jellyfin"
    check_not_running $jellyfin_container
    if [[ ! -z not_running  ]]; then
        if [[ -z $prev_container ]]; then
            [[ -z $(docker volume ls | rg jellyfin-config) ]] && docker volume create jellyfin-config
            [[ -z $(docker volume ls | rg jellyfin-cache) ]] && docker volume create jellyfin-cache
            docker run -d \
                --net=host \
                -e NVIDIA_DRIVER_CAPABILITIES=all \
                -e NVIDIA_VISIBLE_DEVICES=all \
                --runtime=nvidia \
                --gpus all \
                -v jellyfin-config:/config \
                -v jellyfin-cache:/cache \
                -v /home/media:/media \
                --user 1000:1000 \
                --restart unless-stopped \
                jellyfin/jellyfin:nightly 2>&1 > /dev/null
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi