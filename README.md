# My Zsh dotfiles

## Table of Contents

- [About](#about)
    - [Applications included](#apps)
- [Getting Started](#getting_started)
    - [Prerequisites](#prerequisites)

## About <a name = "about"></a>

Personal dotfiles, using zsh and asdf.

### Applications included <a name = "apps"></a>

When setting up this project, multiple additional utilites are also installed:
- [asdf-vm](https://github.com/asdf-vm/asdf), for installing multiple runtimes (set in `.tool-versions` file)
- [exa](https://github.com/ogham/exa), replacing ls with an alias
- [hexyl](https://github.com/sharkdp/hexyl), an hex viewer
- [bat](https://github.com/sharkdp/bat), a similar application to cat but with syntax highlighting (among other functionalities)
- [fd](https://github.com/sharkdp/fd), providing similar functionality to the common find program, while being more efficient
- [ripgrep](https://github.com/BurntSushi/ripgrep), which does the same for grep
- [tldr](https://github.com/tldr-pages/tldr), containing short examples for a lot of tools (for when `man` is too much)

Additionally, [vim-plug](https://github.com/junegunn/vim-plug) is installed in the appropiate folder for [Neovim](https://github.com/neovim/neovim), and my personal [`init.vim`](init.vim) file is likewise linked into place.

## Getting Started <a name = "getting_started"></a>

[Check the prerequisites](#prerequisites).

Afterwards, clone this repo:

```
git clone https://github.com/Kaylebor/zsh_dotfiles.git ~/zsh_dotfiles
cd ~/zsh_dotfiles
```

You may need to change file permissions:
```
chmod +x setup
```

Finally, run the [setup file](setup).
```
bash setup
```

The first time it may take a while, since some steps involve compiling source code.

`setup` contains some additional, optional arguments; check `./setup --help` for more info

### Prerequisites <a name = "prerequisites"></a>

For erlang, [make sure to install the required dependencies](https://github.com/asdf-vm/asdf-erlang#before-asdf-install)
