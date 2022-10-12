#!/bin/zsh

COMMON_FILES_TO_LINK=(
  .asdfrc
  .tool-versions
  .default-gems
  .default-python-packages
  .default-npm-packages
  .config/bat/config
  .config/git/config
  .config/git/.gitignore.global
  .config/nvim/init.vim
  .config/tg/conf.py
  .config/topgrade.toml
  .config/starship.toml
  .doom.d/config.el
  .doom.d/init.el
  .doom.d/packages.el
  .dracula
  .ripgreprc
  .scripts
)

function LinkFilesFromList {
  [[ ! -d $HOME/.backups ]] && mkdir -p $HOME/.backups
  for file in ${1[@]}; do
  [[ -h $HOME/$file ]] && rm $HOME/$file
    [[ -a $HOME/$file ]] && mv $HOME/$file $HOME/.backups/
    ln -s $DIR/$file $HOME/$file
  done
  unset file
}

function LinkGeneralFiles {
  LinkFilesFromList $COMMON_FILES_TO_LINK
  LinkFilesFromList $1
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

function LinkDraculaThemesZSH {
  dracula_zsh_theme=${ZSH:-$HOME/.oh-my-zsh}/themes/dracula.zsh-theme
  [[ -e $dracula_zsh_theme || -h $dracula_zsh_theme ]] && rm $dracula_zsh_theme
  ln -s $DIR/.dracula/zsh/dracula.zsh-theme $dracula_zsh_theme
  unset dracula_zsh_theme
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
