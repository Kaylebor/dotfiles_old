#!/bin/zsh

if [[   -d $ECLIPSE_WORKSPACE && \
        -f $(which docker) && \
        ! -z $(docker image ls | rg kaylebor/eclipse.jdt.ls) && \
        -z $(docker container ps -f 'status=running' -f 'ancestor=kaylebor/eclipse.jdt.ls' | rg --invert-match IMAGE | tr -s ' ' | cut -d ' ' -f 2) ]]; then
    prev_container=$(docker container ps -a -f 'ancestor=kaylebor/eclipse.jdt.ls' | rg --invert-match IMAGE | tail -n1 | tr -s ' ' | cut -d ' ' -f 1)
    if [[ -z $prev_container ]]; then
        docker run -d --net=host -v $ECLIPSE_WORKSPACE:/eclipse-workspace kaylebor/eclipse.jdt.ls 2>&1 > /dev/null
    else
        docker start $prev_container 2>&1 > /dev/null
    fi
fi