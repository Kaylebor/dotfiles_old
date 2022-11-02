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
  echo "Configuring git with:"
  echo "email:       $git_email"
  echo "name:        $git_name"
  echo "github user: $github_user"
  cp .config/git/config $HOME/.config/git/config
  sed -i "s/#NAME/$git_name/g" $HOME/.config/git/config
  sed -i "s/#EMAIL/$git_email/g" $HOME/.config/git/config
  sed -i "s/#GITHUB_USER/$github_user/g" $HOME/.config/git/config
}

function InstallBrew {
  if [[ -z $(command -v brew) ]]; then
    echo "Homebrew missing, attempting to install..."
    if [[ -z $(command -v xcode-select) ]]; then
      echo "Brew could not be installed because Xcode is missing"
      echo "Check Brew homepage for more information:"
      echo "https://docs.brew.sh/Installation"
    else
      echo "Installing brew..."
      xcode-select --install
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      brew bundle $DIR/Brewfile
    fi
  fi
}

function InstallImgcat {
  if [[ -z $(command -v imgcat) ]]; then
    echo "Downloading imgcat..."
    curl -L https://iterm2.com/utilities/imgcat -o $HOME/bin/imgcat
    chmod +x $HOME/bin/imgcat
  fi
}

function InstallASDF {
  if [[ ! -d ${ASDF_DIR:=$HOME/.asdf} ]]; then
    echo "asdf is missing, installing..."
    git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.10.2
    mkdir -p ${ASDF_DATA_DIR:=$HOME/.asdf_shims}
  fi
  echo "Sourcing asdf..."
  . $ASDF_DIR/asdf.sh
}

function InstallASDFLanguages {
  echo "Installing asdf plugins..."
  cat .tool-versions | cut -d' ' -f1 | xargs -I{} asdf plugin-add {}
  echo "Installing asdf languages..."
  asdf install
}

function InstallCargoPackages {
  if [[ -z $(command -v rg) ]]; then
    echo "Ripgrep missing, installing..."
    cargo install --features 'pcre2' ripgrep
  fi
}

function ChangeShell {
  if [[ ! ${SHELL##*/} == $1 ]]; then
    SHELL=$(command -v $1)
    echo "Changing shell to $SHELL..."
    [[ ! $(grep "$SHELL" /etc/shells) ]] && echo $SHELL | sudo tee -a /etc/shells
    chsh -s $SHELL $USER
  fi
}

function DownloadIterm2ShellIntegration {
  if [[ ! -a $2 ]]; then
    echo "Downloading iTerm2 shell integration..."
    curl -L https://iterm2.com/shell_integration/$1 -o $2
  fi
}

function ConfigureNeovim {
  vim_plug_file="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
  if [[ ! -f $vim_plug_file ]]; then
    echo "Plug missing; downloading..."
    sh -c "curl -fLo $vim_plug_file --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  fi
  echo "Installing Neovim plugins..."
  nvim -c ':PlugInstall' -c 'call input("Press any key to continue")' -c ':qa'
}

function Cleanup {
  unset FILES_TO_LINK
  unset DIR
  unset git_email
  unset git_name
  unset asdf_repo
  unset vim_plug_file
}

function Finish {
  echo "Finished; you may have to reopen the shell, source .zshrc again, or run 'exec -l \$SHELL'"
  echo "Running 'exec -l \$SHELL' now"
  exec -l $SHELL
}
