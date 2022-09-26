# PATH additions
fish_add_path ~/.bin
fish_add_path ~/go/bin

# Disable greeting message
set -U fish_greeting

# Environment variables
set -gx BAT_THEME Dracula
set -gx DISABLE_AUTO_TITLE true
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx FZF_TMUX 1
set -gx LANG C.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx TIME_STYLE long-iso

# Set emacs as default editor
set -gx EDITOR "emacs -nw"

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/title/XDG_Base_Directory#Support
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state

# Enable starship.rs prompt
if command -qv starship
    starship init fish | source
end

# Choose Dracula color theme
fish_config theme choose Dracula

if status is-interactive
    # Commands to run in interactive sessions can go here
end
