{ pkgs, ... }: {
  require = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
    ./tmux.nix
    ./local.nix
  ];
  
  home.packages = with pkgs; [
    exa
    hexyl
    fd
    wget
    ripgrep
    ripgrep-all
    bat
    fzf
    gitAndTools.delta
    abduco
    dvtm
    httpie
    parallel
    shellcheck
    visidata
    nixfmt
  ];

  programs.topgrade = {
    enable = true;
    settings = {
      disable = [
        "node"
        "shell"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  programs.bat.themes.dracula = "$HOME/.bat-themes/Dracula.tmTheme";
}
