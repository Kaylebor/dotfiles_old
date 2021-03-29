{ pkgs, ... }: {
  require = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
  ];
  
  home.packages = with pkgs; [
    exa
    hexyl
    fd
    ripgrep
    ripgrep-all
    bat
    fzf
    direnv
    gitAndTools.hub
    gitAndTools.delta
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  programs.bat.themes = {
    dracula = "$HOME/.bat-themes/Dracula.tmTheme";
  };
}
