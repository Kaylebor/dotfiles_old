#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

asdf_install_latest() {
    installed_plugins=$(asdf plugin-list)
    [[ ! $installed_plugins =~ $1 ]] && asdf plugin-add $1
    [[ $(asdf list $1 2>&1) =~ "No versions installed" ]] && asdf install $1 latest
    [[ $(asdf current $1 2>&1) =~ "No version set" ]] && asdf global $1 $(asdf list $1 | tail -n1)
}

asdf_update_latest() {
    installed_plugins=$(asdf plugin-list)
    if [[ ! $installed_plugins =~ $1 ]]; then
        asdf_install_latest $1
    else
        installed_latest=$(asdf list $1 | tail -n1)
        available_latest=$(asdf list-all $1 | grep -v latest | tail -n1)
        if [[ $installed_latest != $available_latest ]]; then
            asdf install $1 $available_latest
            asdf global $1 $available_latest
        fi
    fi
}

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
