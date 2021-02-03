# My Zsh dotfiles

## Table of Contents

- [About](#about)
    - [Applications included](#apps)
- [Getting Started](#getting_started)

## About <a name = "about"></a>

Personal dotfiles, using zsh and Nix.
Everything is installed using [Home Manager](https://github.com/nix-community/home-manager); see [nixpkgs/home.nix](nixpkgs/home.nix) for configuration.

### Applications included <a name = "apps"></a>

When setting up this project, multiple additional utilites are also installed:
- [Home Manager](https://github.com/nix-community/home-manager), wich enables relatively simple, centralized configuration and installation of everything below.
- [Nix Package Manager](https://nixos.org/), used by Home Manager. Designed for NixOS, but should work on any Linux distro or Mac.
- [exa](https://github.com/ogham/exa), replacing ls with an alias.
- [hexyl](https://github.com/sharkdp/hexyl), an hex viewer.
- [bat](https://github.com/sharkdp/bat), a similar application to cat but with syntax highlighting (among other functionalities).
- [fd](https://github.com/sharkdp/fd), providing similar functionality to the common find program, while being more efficient.
- [ripgrep](https://github.com/BurntSushi/ripgrep), which does the same for grep.
- [Neovim](https://github.com/neovim/neovim), with my personal configuration.
- [zsh](https://www.zsh.org/), if it is not already installed; set as default shell.

## Getting Started <a name = "getting_started"></a>

Clone this repo:

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
./setup
```

The first time it may take a while, since some steps involve compiling source code.
