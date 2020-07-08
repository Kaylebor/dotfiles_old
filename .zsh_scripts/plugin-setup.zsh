#!/bin/zsh
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
zinit light-mode depth=1 for romkatv/powerlevel10k

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

# Installs vim-plug
vimplugpath="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload"
zinit as"null" atpull"!mkdir -p $vimplugpath" cp"plug.vim -> $vimplugpath/plug.vim" for junegunn/vim-plug

zinit as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
        atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal" for light-mode k4rthik/git-cal

# Gitignore plugin – commands gii and gi
zinit wait"2" lucid for voronkovich/gitignore.plugin.zsh

# adds integration with asdf to zsh
zinit pick'asdf.sh' for light-mode @asdf-vm/asdf

# github/hub
zinit from'gh-r' as'program' bpick'*linux-amd64*' pick'*/bin/hub' atclone'rm hub-linux-*/share/man/man1/*.txt' for @github/hub

# zaquestion/lab
zinit from'gh-r' as'program' bpick'*linux_amd64*' pick'lab' for zaquestion/lab

# jarun/googler
zinit from'gh-r' as'program' bpick'*x86_64*' pick'*/bin/googler' for jarun/googler

zinit cdreplay -q # <- execute compdefs provided by rest of plugins