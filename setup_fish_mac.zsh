#!/bin/zsh

unameOut=$(uname -s) # Used to differentiate Mac from other UNIX-like systems
if [[ $(uname -s) != Darwin ]]; then
    echo "Error: System is not MacOS; aborting."
    exit 1
fi
unset unameOut

FILES_TO_LINK=(
  .asdfrc
  .config/bat/config
  .config/fish/config.fish
  .config/fish/fish_plugins
  .config/fish/functions/fish_prompt.fish
  .config/fish/functions/fish_right_prompt.fish
  .config/git/.gitignore.global
  .config/git/config
  .config/nvim/init.vim
  .config/starship.toml
  .config/tg/conf.py
  .config/topgrade.toml
  .default-gems
  .default-python-packages
  .doom.d/config.el
  .doom.d/init.el
  .doom.d/packages.el
  .dracula
  .ripgreprc
  .scripts
  .tool-versions
)

DIR="$( cd -- "$(dirname "$0")" || exit >/dev/null 2>&1 ; pwd -P )"

function Help {
  echo "Installs and configures the dotfiles, as seen in README.md"
  echo ""
  echo "Usage: $0"
  echo "options:"
  echo "  -h, --help      displays this message"
  echo "  --git-email     global git configuration email"
  echo "  --git-name      global git configuration name"
  echo "  --github-user   global git configuration github user"
  exit "$1"
}

function MissingOptionError {
  echo "Error: Option $1 must be present; aborting"
  exit 1
}

function LinkGeneralFiles {
  [[ ! -d $HOME/.backups ]] && mkdir -p $HOME/.backups
  for file in ${FILES_TO_LINK[@]}; do
    [[ -h $HOME/$file ]] && rm $HOME/$file
    [[ -a $HOME/$file ]] && mv $HOME/$file $HOME/.backups/
    ln -s $DIR/$file $HOME/$file
  done
  unset file
}

function LinkDraculaThemes {
  # Installing Dracula themes
  git submodule update --init --recursive --force

  # Sublime theme (for bat)
  bat_config_dir=$(bat --config-dir)
  mkdir -p $bat_config_dir/themes
  [[ ! -e $bat_config_dir/config ]] && bat --generate-config-file
  dracula_sublime_theme=$bat_config_dir/themes/Dracula.tmTheme
  [[ -e $dracula_sublime_theme || -h $dracula_sublime_theme ]] && rm $dracula_sublime_theme
  ln -s $DIR/.dracula/sublime/Dracula.tmTheme $dracula_sublime_theme
  unset bat_config_dir
  unset dracula_sublime_theme
}

function LinkGithubConfig {
  if [[ ! -e $DIR/.config/git/.local.gitconfig ]]; then
    cp $DIR/.config/git/local.template.config $DIR/.config/git/.local.gitconfig
  fi
  [[ -h $HOME/.local.gitconfig ]] && rm $HOME/.local.gitconfig
  if [[ ! -e $HOME/.local.gitconfig ]]; then
    ln -s $DIR/.config/git/.local.gitconfig $HOME/.local.gitconfig
  fi
}

while getopts "h-:" optchar; do
  case $optchar in
  -)
    case $OPTARG in
    git-email)
      git_email="${!OPTIND}"
      ;;
    git-email=*)
      git_email=${OPTARG#*=}
      ;;
    git-name)
      git_name="${!OPTIND}"
      ;;
    git-name=*)
      git_name=${OPTARG#*=}
      ;;
    github-user=*)
      github_user=${OPTARG#*=}
      ;;
    link-only)
      LinkGeneralFiles
      LinkDraculaThemes
      LinkGithubConfig
      exit 0
      ;;
    help)
      Help 0
      ;;
    esac
    ;;
  h|*)
    Help 0
    ;;
  esac
done

# Check mandatory values
if [[ -z $git_email ]]; then
  MissingOptionError git-email
fi
if [[ -z $git_name ]]; then
  MissingOptionError git-name
fi
if [[ -z $github_user ]]; then
  MissingOptionError github-name
fi

# Configuring local Git configuration
LinkGithubConfig
sed -i "s/#EMAIL/$git_email/g" $HOME/.gitconfig.local
sed -i "s/#NAME/$git_name/g" $HOME/.gitconfig.local
sed -i "s/#GITHUB_USER/$github_user/g" $HOME/.gitconfig.local

# Linking files
LinkGeneralFiles

# Installing Brew and packages
if [[ -z $(command -v xcode-select) ]]; then
  echo "Brew could not be installed because Xcode is missing"
  echo "Check Brew homepage for more information:"
  echo "https://docs.brew.sh/Installation"
else
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew bundle $DIR/Brewfile
fi

if [[ ! ${SHELL##*/} == fish ]]; then
  SHELL=$(command -v fish)
  [[ ! $(grep "$SHELL" /etc/shells) ]] && echo $SHELL | sudo tee -a /etc/shells
  chsh -s $SHELL $USER
fi

# Installing Fisher and plugins
if [[ -z $(command -v fisher) ]]; then
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher update
fi

# Installing asdf
if [[ -a /usr/local/opt/asdf/libexec/asdf.sh ]]; then
  source /usr/local/opt/asdf/libexec/asdf.sh
else
  asdf_repo=$HOME/.asdf
  git clone https://github.com/asdf-vm/asdf.git $asdf_repo --branch v0.10.0
  source $asdf_repo/asdf.sh
  unset asdf_repo
fi

# Installing asdf languages
asdf install

# Install packages with Yarn
for package in (bash-language-server flow-bin); do
  yarn install $package
unset package

# iTerm2 integration
iterm_integration_file=$HOME/.iterm2_shell_integration.fish
if [[ ! -a $iterm_integration_file ]]; then
  echo "Downloading iTerm2 shell integration..."
  curl -L https://iterm2.com/shell_integration/fish -o $iterm_integration_file
fi
unset iterm_integration_file

# cht.sh
if [[ ! -f ~/.config/fish/functions/cheat.sh.fish ]]; then
    curl https://cht.sh/:cht.sh -o ~/.config/fish/functions/cheat.sh.fish
fi

LinkDraculaThemes

# Neovim configuration
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c ':PlugInstall' -c 'call input("Press any key to continue")' -c ':qa'

# Create completions from existing man pages
fish_update_completions

# Cleanup
unset FILES_TO_LINK
unset DIR
unset git_email
unset git_name

echo "Finished; you may have to reopen the shell, source .zshrc again, or run 'exec -l \$SHELL'"
echo "Running 'exec -l \$SHELL' now"

exec -l $SHELL
