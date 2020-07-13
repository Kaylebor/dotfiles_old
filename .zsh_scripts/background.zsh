#!/bin/zsh

check-running-containers() {
    echo $(docker container ps -f 'status=running' -f "ancestor=$1" | tail -n +2 | wc -l)
}

check-previous-container-name() {
    echo $(docker container ps -a -f "ancestor=$1" | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
}

if [[ $ENABLE_JDT -eq 1 ]]; then
    jdt_container="kaylebor/eclipse.jdt.ls"
    if [[ $(check-running-containers $jdt_container) -ge 1  ]]; then
        prev_container=$(check-previous-container-name $jdt_container)
        if [[ -z $prev_container ]]; then
            docker run -d --net=host $jdt_container 2>&1 > /dev/null
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi

if [[ $ENABLE_JELLYFIN -eq 1 ]]; then
    jellyfin_container="jellyfin/jellyfin"
    if [[ $(check-running-containers $jdt_container) -ge 1  ]]; then
        prev_container=$(check-previous-container-name $jdt_container)
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