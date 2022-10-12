#!/bin/zsh

function Help {
  echo "Installs and configures the dotfiles, as seen in README.md"
  echo ""
  echo "Usage: $0"
  echo "options:"
  echo "  -h, --help      displays this message"
  echo "  --git-email     global git configuration email"
  echo "  --git-name      global git configuration name"
  echo "  --github-user   global git configuration github user"
  echo "  --link-only     only link files"
  exit "$1"
}

function MissingOptionError {
  echo "Error: Option $1 must be present; aborting"
  exit 1
}

function CheckMandatoryValues {
  if [[ -z $git_email ]]; then
  MissingOptionError git-email
  fi
  if [[ -z $git_name ]]; then
    MissingOptionError git-name
  fi
  if [[ -z $github_user ]]; then
    MissingOptionError github-name
  fi
}

function ConfigureGit {
  sed -i "s/#EMAIL/$git_email/g" $HOME/.gitconfig.local
  sed -i "s/#NAME/$git_name/g" $HOME/.gitconfig.local
  sed -i "s/#GITHUB_USER/$github_user/g" $HOME/.gitconfig.local
}

function InstallBrew {
  if [[ -z $(command -v xcode-select) ]]; then
    echo "Brew could not be installed because Xcode is missing"
    echo "Check Brew homepage for more information:"
    echo "https://docs.brew.sh/Installation"
  else
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew bundle $DIR/Brewfile
  fi
}

function ChangeShell {
  if [[ ! ${SHELL##*/} == $1 ]]; then
    SHELL=$(command -v $1)
    [[ ! $(grep "$SHELL" /etc/shells) ]] && echo $SHELL | sudo tee -a /etc/shells
    chsh -s $SHELL $USER
  fi
}

function InstallASDF {
  if [[ ! -d ${ASDF_DIR:=$HOME/.asdf} ]]; then
    git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.10.2
    mkdir -p ${ASDF_DATA_DIR:=$HOME/.asdf_shims}
  fi
  . $ASDF_DIR/asdf.sh
}

function InstallASDFLanguages {
  cat .tool-versions | cut -d' ' -f1 | xargs -I{} asdf plugin-add {}
  asdf install
}

function DownloadIterm2ShellIntegration {
  if [[ ! -a $2 ]]; then
    echo "Downloading iTerm2 shell integration..."
    curl -L https://iterm2.com/shell_integration/$1 -o $2
  fi
}

function ConfigureNeovim {
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim -c ':PlugInstall' -c 'call input("Press any key to continue")' -c ':qa'
}

function Cleanup {
  unset FILES_TO_LINK
  unset DIR
  unset git_email
  unset git_name
  unset asdf_repo
}

function Finish {
  echo "Finished; you may have to reopen the shell, source .zshrc again, or run 'exec -l \$SHELL'"
  echo "Running 'exec -l \$SHELL' now"
  exec -l $SHELL
}
