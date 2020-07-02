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

# Java Language Server
eclipse.jdt.start() {
    # Needs Java 8 to be installed first
    if [[ -d "/usr/lib/jvm/java-1.8.0-openjdk-amd64/" ]]; then
        prev_folder=$(pwd)
        [[ -z $ECLIPSE_JDT_PATH ]] && ECLIPSE_JDT_PATH="$HOME/.eclipse.jdt.ls"
        ECLIPSE_JDT_TARGET="$ECLIPSE_JDT_PATH/org.eclipse.jdt.ls.product/target/repository"

        puid_prev_service=$(ps aux | grep "org.eclipse.equinox.launcher" | grep -v "grep" | tr -s ' ' | cut -d' ' -f2)

        if [[ ! -d $ECLIPSE_JDT_PATH ]]; then
            git clone https://github.com/eclipse/eclipse.jdt.ls $ECLIPSE_JDT_PATH
            REBUILD_ECLIPSE_JDT=true
        fi
        if [[ ! -z $REBUILD_ECLIPSE_JDT ]]; then
            cd $ECLIPSE_JDT_PATH
            git pull

            [[ -z $ECLIPSE_WORKSPACE ]] && ECLIPSE_WORKSPACE=$HOME/eclipse-workspace
            [[ -d $ECLIPSE_WORKSPACE ]] && mkdir -p $ECLIPSE_WORKSPACE

            JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-amd64/' ./mvnw clean verify
            kill -s SIGINT $puid_prev_service
            unset puid_prev_service
        fi
        if [[ -z $puid_prev_service ]]; then
            cd $ECLIPSE_JDT_TARGET

            launcher_file_name=$(find ./plugins -name "org.eclipse.equinox.launcher_*.jar" | sort | head -n 1)
            java_version=$(java -version 2>&1 | grep version | awk '{print $3}' | sed 's|"||g' | cut -d'_' -f1 | cut -s -d'.' -f 1,2)

            java_args="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
                -Declipse.application=org.eclipse.jdt.ls.core.id1 \
                -Dosgi.bundles.defaultStartLevel=4 \
                -Declipse.product=org.eclipse.jdt.ls.core.product \
                -Dlog.level=ALL -noverify -Xmx1G \
                -jar $launcher_file_name \
                -configuration ./config_linux \
                -data $ECLIPSE_WORKSPACE"

            [[ $java_version -gt 1.8 ]] && java_args+=" --add-modules=ALL-SYSTEM \
                --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED"

            nohup java $(sed 's|\n||g' <<< $java_args | tr -s ' ') </dev/null &> $ECLIPSE_JDT_PATH/jdt.log &
        fi
        cd $prev_folder
    fi
}
