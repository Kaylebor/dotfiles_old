#!/bin/zsh

asdf-install-latest() {
    installed_plugins=$(asdf plugin list)
    [[ ! $installed_plugins =~ $1 ]] && asdf plugin add $1
    [[ "nodejs" = $1 ]] && bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    [[ $(asdf list $1 2>&1) =~ "No versions installed" ]] && asdf install $1 latest
    [[ $(asdf current $1 2>&1) =~ "No version set" ]] && asdf global $1 $(asdf list $1 | tail -n1)
}

asdf-update-latest() {
    installed_plugins=$(asdf plugin-list)
    if [[ ! $installed_plugins =~ $1 ]]; then
        asdf-install-latest $1
    else
        installed_latest=$(asdf list $1 | tail -n1)
        available_latest=$(asdf list all $1 | grep -v latest | tail -n1)
        if [[ $installed_latest != $available_latest ]]; then
            asdf install $1 $available_latest
            asdf global $1 $available_latest
        fi
    fi
}

if [[ -f $(which asdf) ]]; then
    for plugin in rust golang maven nodejs yarn; do
        asdf-install-latest $plugin
    done
fi