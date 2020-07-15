#!/bin/zsh

check-running-containers() {
    echo $(docker container ps -f 'status=running' -f "ancestor=$1" | tail -n +2 | wc -l)
}

check-previous-container-name() {
    echo $(docker container ps -a -f "ancestor=$1" | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
}

if [[ $ENABLE_JDT -eq 1 ]]; then
    container_name="kaylebor/eclipse.jdt.ls"
    if [[ $(check-running-containers $container_name) -lt 1  ]]; then
        prev_container=$(check-previous-container-name $container_name)
        if [[ -z $prev_container ]]; then
            docker run -d --net=host $container_name 2>&1 > /dev/null
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi

if [[ $ENABLE_JELLYFIN -eq 1 ]]; then
    container_name="jellyfin/jellyfin"
    if [[ $(check-running-containers $container_name) -lt 1  ]]; then
        prev_container=$(check-previous-container-name $container_name)
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
                $container_name:nightly 2>&1 > /dev/null
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi

if [[ $ENABLE_JUPYTER_MINIMAL -eq 1 ]]; then
    container_name="jupyter/minimal-notebook"
    if [[ $(check-running-containers $container_name) -lt 1  ]]; then
        prev_container=$(check-previous-container-name $container_name)
        if [[ -z $prev_container ]]; then
            docker run -d -p 8888:8888 $container_name
        else
            docker start $prev_container 2>&1 > /dev/null
        fi
    fi
fi