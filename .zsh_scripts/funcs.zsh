#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

jellyfin_start() {
  [[ -z $(docker volume ls | rg jellyfin-config) ]] && docker volume create jellyfin-config
  [[ -z $(docker volume ls | rg jellyfin-cache) ]] && docker volume create jellyfin-cache
  docker run -d -v jellyfin-config:/config -v jellyfin-cache:/cache -v /home/media:/media --user 1000:1000 --net=host jellyfin/jellyfin:latest
}

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
