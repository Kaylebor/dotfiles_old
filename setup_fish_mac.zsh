#!/bin/zsh

unameOut=$(uname -s) # Used to differentiate Mac from other UNIX-like systems
if [[ $(uname -s) != Darwin ]]; then
    echo "Error: System is not MacOS; aborting."
    exit 1
fi
unset unameOut

FILES_TO_LINK=(
  .config/fish/config.fish
  .config/fish/fish_plugins
  .config/fish/conf.d/mac.fish
  .config/fish/completions/mix.fish
  .config/fish/functions/emacsc.fish
  .config/fish/functions/wttr.fish
)

DIR="$( cd -- "$(dirname "$0")" || exit >/dev/null 2>&1 ; pwd -P )"

source $DIR/setup_bin/link_functions.zsh

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
      LinkGeneralFiles $FILES_TO_LINK
      LinkDraculaThemes
      LinkGithubConfig
      ConfigureGit
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

source $DIR/setup_bin/utils.zsh

CheckMandatoryValues

LinkGeneralFiles $FILES_TO_LINK

LinkGithubConfig
ConfigureGit

InstallBrew

ChangeShell fish

# Fish-specific configurations
fish $DIR/setup_bin/setup.fish

InstallASDF
InstallASDFLanguages

DownloadIterm2ShellIntegration fish ~/.config/fish/conf.d/iterm2_shell_integration.fish

# Installing other tools
InstallImgcat

LinkDraculaThemes

ConfigureNeovim

Cleanup

Finish
