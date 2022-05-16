#!/bin/zsh

# Load Brew completions
if type brew &>/dev/null; then
  brew_site_functions=$(brew --prefix)/share/zsh/site-functions
  fpath=($brew_site_functions $fpath)
  for func_name in $(ls $brew_site_functions)
    autoload -Uz $func_name
  unset brew_site_functions
fi

# Load custom scripts
fpath=($HOME/.scripts/zsh/zsh-functions $fpath)
for func_name in $(ls $HOME/.scripts/zsh/zsh-functions)
  autoload -Uz $func_name
unset func_name

# Completion definitions for 1Password command line tool
if [[ -n $(command -v op) ]]; then
  eval "$(op completion zsh)"
  compdef _op op
fi

local source_files=(
  $HOME/.scripts/zsh/keybindings-fix.zsh
  $HOME/.nix-profile/etc/profile.d/nix.sh
  $HOME/.local.zsh
)

for file in $source_files
  [[ -e $file ]] && source $file
unset file
unset source_files

# Define JAVA_HOME from asdf
if command -v asdf &> /dev/null; then
  export $(asdf env java | grep JAVA_HOME)
fi

# Configuring YubiKey
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

iterm_integration_file=$HOME/.iterm2_shell_integration.zsh
if [[ ! -a $iterm_integration_file ]]; then
  echo "Downloading iTerm2 shell integration..."
  curl -L https://iterm2.com/shell_integration/zsh -o $iterm_integration_file
fi
if [[ -o interactive && $TERM != "screen" && $TERM_PROGRAM = "iTerm.app" && -z $INSIDE_EMACS ]]; then
  source $iterm_integration_file
fi
unset iterm_integration_file

if [[ -n $(command -v tmuxp) ]]; then
  eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

path=(.git/safe/../../bin $HOME/.bin $path)

# Opam package manager
eval $(opam env)

# fzf integration
[[ -f ~/.fzf.zsh ]] && source $HOME/.fzf.zsh

# Disable history expansion with '!''
setopt nobanghist

# Use tmux on certain environments (for multipane support mostly)
if command -v tmux &> /dev/null && [[ -n $PS1 ]] && [[ -z $TMUX ]] && [[ ! $TERM =~ "screen|tmux" ]] && [[ ! $TERM_PROGRAM =~ '(WarpTerminal|iTerm.app|vscode)' ]]; then
  exec tmux
fi
