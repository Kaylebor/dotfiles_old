#!/bin/zsh

COMPOSE_FILE=$(dirname -- "$0")/../docker/docker-compose.yml
[[ $ENABLE_JELLYFIN -eq 1 ]] && docker-compose -f $COMPOSE_FILE --log-level ERROR up -d jellyfin
