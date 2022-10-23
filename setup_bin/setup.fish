# Modifying PATH
fish_add_path ~/bin
fish_add_path ~/go/bin

# Disable greeting message
set -U fish_greeting

# Environment variables
set -Ux BAT_THEME Dracula
set -Ux DISABLE_AUTO_TITLE true
set -Ux ERL_AFLAGS "-kernel shell_history enabled"
set -Ux FZF_TMUX 1
set -Ux LANG C.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ux RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -Ux TIME_STYLE long-iso

# Set emacs as default editor
set -Ux EDITOR "emacs -nw"

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/title/XDG_Base_Directory#Support
set -Ux XDG_CONFIG_HOME ~/.config
set -Ux XDG_DATA_HOME ~/.local/share
set -Ux XDG_CACHE_HOME ~/.cache
set -Ux XDG_STATE_HOME ~/.local/state

# Set asdf variables
set -Ux ASDF_DIR ~/.asdf
set -Ux ASDF_DATA_DIR ~/.asdf_data

# Custom asdf install, since the wrapper does not work properly on my machine
fish_add_path -pm /usr/local/opt/coreutils/libexec/gnubin
fish_add_path -pm /usr/local/opt/curl/bin
fish_add_path -pm /usr/local/opt/gnu-getopt/bin
fish_add_path -pm /usr/local/opt/gnu-indent/libexec/gnubin
fish_add_path -pm /usr/local/opt/gnu-sed/libexec/gnubin
fish_add_path -pm /usr/local/opt/gnu-tar/libexec/gnubin
fish_add_path -pm /usr/local/opt/wget/bin
fish_add_path -pm $ASDF_DIR/bin
fish_add_path -pm $ASDF_DATA_DIR/shims
ln -s $ASDF_DIR/lib/asdf.fish ~/.config/fish/functions/asdf.fish

# This path addition means that local files in `project/bin` override global path executables
# It is specially useful when working with Rails projects
set fish_user_paths .git/safe/../../bin $fish_user_paths

# Choose Dracula color theme
fish_config theme choose Dracula

# Installing Fisher and plugins
if not command -qv fisher
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
fisher update

# Create completions for 1Password CLI
op completion fish > ~/.config/fish/completions/op.fish

# Link completions for asdf
ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions/asdf.fish

fish_update_completions
