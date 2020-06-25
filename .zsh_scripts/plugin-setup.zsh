# Requires zinit: https://github.com/zdharma/zinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

### End of Zinit's installer chunk

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# adds keyword _evalcache to cache output of configuration commands
# _evalcache_clear clears this cache
zinit load mroth/evalcache

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word
# man page generator for plugins

# colors when running ls
zinit pack for ls_colors

# oh-my-zsh plugin that abstracts specifics about extracting compressed files
# behind a single 'extract' command
zinit snippet OMZ::plugins/extract

# adds a function cpv that uses rsync to copy
zinit snippet OMZ::plugins/cp

# adds integration with asdf to zsh
zinit ice pick'asdf.sh'
zinit light asdf-vm/asdf